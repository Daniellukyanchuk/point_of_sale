class Inventory < ApplicationRecord
  belongs_to :product
  before_save :set_costs

  def self.search(search, product_select, start_date, end_date)
    # my_hash = {a: "yo", b: "man"}
    # my_hash.each do |key, value|
    #   stop
    # end
    where_statements = []

    if !search.blank?
      tmp = "(products.product_name ILIKE '%#{search}%' 
               OR product_id = #{search.to_i} OR amount = #{search.to_d} 
               OR price_per_unit = #{search.to_d} or costs = #{search.to_d} 
               OR current_amount_left = #{search.to_d})"
      
      where_statements.push(tmp)
    end

    if !product_select.blank?
      ids = []
      product_select.each do |ps|
        ids.push(ps.to_i)
      end
      tmp = "product_id in (#{SqlHelper.escape_sql_param(ids)})"
      where_statements.push(tmp)
    end

    if !start_date.blank? && !end_date.blank?
      where_statements.push("(CAST(inventories.created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} AND CAST(inventories.created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)})")
    end

    where_clause = where_statements.join(" AND ")
    return Inventory.joins(:product).where(where_clause)
  end

  def self.current_inventory_for(product_id)
  	return Inventory.where("product_id = ? and current_amount_left > 0", product_id).sum(&:current_amount_left)
  end
  
  def set_costs  	
  	if self.current_amount_left == nil
  		self.current_amount_left = 0
  	end
    self.costs = self.amount * self.price_per_unit
    # Delta of purchased shows the change and what was saved. If it were 100 saved and then they decided to change it to 120, then the delta is 20.
    delta_of_purchased = self.amount - (self.amount_was || 0)
    self.current_amount_left = self.current_amount_left + delta_of_purchased   
  end
end