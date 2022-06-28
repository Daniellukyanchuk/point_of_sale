class Order < ApplicationRecord 
  before_destroy :put_back_inventory_item
  has_many :order_products, dependent: :delete_all 
  accepts_nested_attributes_for :order_products, allow_destroy: true
  belongs_to :client, optional: true  
  before_save :set_grand_total, :manage_discounts, :create_clients, :expiration_amount_valid?
  has_one_attached :cover_picture
  validates :client_id, presence: true

  attr_accessor :name, :phone, :address, :city, :country

  def set_grand_total
    order_products.each do |op|
      op.set_subtotal 
    end
  end
  
  def expiration_amount_valid?
    discounts = Discount.where("client_id = ? and (starting_date is null or starting_date < ?) 
    and (ending_date is null or ending_date < ?) and (expiration_amount > 0 
    or expiration_amount is null)", client_id, created_at || DateTime.now, created_at || DateTime.now).order("discount_per_kilo desc, current_expiration_amount asc")

    # Go through order and set order_product.subtotal with a discount.
    self.grand_total = 0
    order_products.each do |op|
      amount_left_to_apply_from_discount = op.quantity
      op.client_discount = 0 

      discounts.each do |d|
        if d.current_expiration_amount >= amount_left_to_apply_from_discount
          op.client_discount += (amount_left_to_apply_from_discount / op.quantity) * d.discount_per_kilo
          d.current_expiration_amount -= amount_left_to_apply_from_discount
          
          d.save
          break
        else
          amount_to_apply = [d.current_expiration_amount, amount_left_to_apply_from_discount].min
   
          op.client_discount += (d.current_expiration_amount / op.quantity) * d.discount_per_kilo
          
          amount_left_to_apply_from_discount -= amount_to_apply

          d.current_expiration_amount = 0
          d.save
        end
        op.order_product_discounts.push OrderProductDiscount.new(discount_id: discounts.first.id, discount_quantity: amount_left_to_apply_from_discount)
      end
      op.subtotal -= op.client_discount * op.quantity
      self.grand_total += op.subtotal
    end
  end

  def create_clients
    if client_id.nil?
      new_client = Client.create(name: name, phone: phone, address: address, city: city, country: country)
      self.client_id = new_client.id
    end
  end
      
  def put_back_inventory_item
    order_products.each do |op|
      Inventory.add_inventory(op.product_id, op.quantity, op.sale_price)

# What's the relationship between order_products, discounts and order_product_discounts? 


      
    end
  end

  def manage_discounts
    if !order_discount.nil?
      order_products.each do |op|
        op.set_subtotal 
        op.percentage_of_total = op.subtotal / grand_total
        op.discount_to_apply = op.percentage_of_total * order_discount
        op.discount_per_unit = op.discount_to_apply / op.quantity
      end
    end
  end
  
  def self.search(search, client_select, start_date, end_date)
    where_statements = []
    if !search.blank?
      tmp = "(clients.name ILIKE '%#{search}%' 
             OR clients.id = #{search.to_i})"
      where_statements.push(tmp)
    end

    if !client_select.blank?
      ids = []
      client_select.each do |cs|
        ids.push(cs.to_i)
      end
      tmp = "clients.id in (#{SqlHelper.escape_sql_param(ids)})"
      where_statements.push(tmp)
    end 

    if !start_date.blank? && !end_date.blank?
      where_statements.push("(CAST(orders.created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} AND CAST(orders.created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)})")
    end
    
    where_clause = where_statements.join(" AND ")
    return Order.includes(:client).where(where_clause)
  end

  def self.client_report(search_text, client_ids, sortable, sort_direction)       
    if !["client_id", "clients_name", "total_money_spent", "number_of_orders"].include?(sortable)
      sortable = "client_id"  
    end

    if sort_direction == "desc"
      "desc"       
    else
      sort_direction = "asc"
    end
    
    search_text_where = "clients_name ILIKE '%#{search_text}%' 
                         OR total_money_spent = #{search_text.to_d} 
                         OR client_id = #{search_text.to_i} 
                         OR number_of_orders = #{search_text.to_i}"
    if search_text.blank?
      search_text_where = ""
    end

    if client_ids.blank? || client_ids == [""]
      client_id_where = ""
    else
      client_id_where = "client_id IN (#{client_ids.join(", ")})"
    end

    where_clause = WhereBuilder.build([client_id_where, search_text_where])

    sql = """
        SELECT *
        FROM (
          SELECT DISTINCT(client_id), clients.name AS clients_name,
          SUM(grand_total) AS total_money_spent,
          COUNT(orders.id) AS number_of_orders 
          FROM orders           
          JOIN clients ON orders.client_id=clients.id
          GROUP BY client_id, clients.name     
        ) report
        #{where_clause} 
        ORDER BY #{sortable} #{sort_direction}
      """
    result = ActiveRecord::Base.connection.execute(sql)      
  end

    # sortable must be a column in this report
  def self.product_report(search_text, product_ids, start_date, end_date, sortable, sort_direction)
    if !["product_id", "product_name", "price", "amount_sold", "amount_made", "average_unit_price", "weighted_average_sale_price"].include?(sortable)
      sortable = "product_name"  
    end      

    if sort_direction  == "desc"
      "desc"      
    else
      sort_direction = "asc"
    end
    search_text_where = " (product_name ILIKE '%#{search_text}%' 
                           OR price = #{search_text.to_d} 
                           OR amount_sold = #{search_text.to_d} 
                           OR amount_made = #{search_text.to_d} 
                           OR average_unit_price = #{search_text.to_d} 
                           OR product_id = #{search_text.to_i} )"     
    
    if search_text.blank?
      search_text_where = ""
    end

    if product_ids.blank? || product_ids == [""]
      product_id_where = ""
    else
      product_id_where = "(product_id IN (#{product_ids.join(", ")}) )"
    end
    
    date_filter_where = "WHERE created_at >= cast(now() as date) - interval '30' day"
    if start_date.blank? || end_date.blank?
      date_filter_where = "WHERE created_at >= cast(now() as date) - interval '30' day" 
    else
      date_filter_where = "WHERE CAST(created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} 
                           AND CAST(created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)}"
    end  

    where_clause = WhereBuilder.build([product_id_where, search_text_where])
    

    sql = """
          SELECT *
          FROM (
                SELECT 
                     sale_prices.product_id,
                     products.product_name,
                     products.price,
                     sale_prices.amount_sold,
                     sale_prices.amount_made,
                     sale_prices.average_unit_price,
                     sale_prices.weighted_average_sale_price,
                     weighted_average_sale.weighted_average
                FROM products
                INNER JOIN 
                          (
                           SELECT  
                              SUM(quantity) AS amount_sold, 
                              SUM(subtotal) AS amount_made,
                              round(AVG(sale_price)::numeric, 2) AS average_unit_price,
                              product_id,
                              SUM(sale_price * quantity) / SUM(NULLIF(quantity,0)) AS weighted_average_sale_price
                           FROM order_products
                           #{date_filter_where}
                           GROUP BY product_id
                          ) sale_prices ON products.id = sale_prices.product_id
                INNER JOIN 
                          (
                           SELECT 
                             product_id, 
                             ROUND(SUM(price_per_unit * current_amount_left) / SUM(NULLIF(current_amount_left,0)), 2) AS weighted_average
                           FROM inventories
                           GROUP BY product_id
                          ) weighted_average_sale on products.id = weighted_average_sale.product_id
                  
                ) report
                #{where_clause}
          ORDER BY #{sortable} #{sort_direction}                      
      """
    result = ActiveRecord::Base.connection.execute(sql)
  end
end