class Inventory < ApplicationRecord
  belongs_to :product
  before_save :set_costs

  def self.search(search, product_select, start_date, end_date)

    # where_sql = "product_id = :product_id and from_date > :start_date"
    # where_params = {product_id: 3}
    # where_params[:start_date] = start_date.to_date

    # Inventory.where(where_sql, where_params)
    search_one = Inventory.joins(:product)
      .where("products.product_name ilike ? 
          or product_id = ? or amount = ? 
          or price_per_unit = ? or costs = ? 
          or current_amount_left = ?", "%#{search}%", search.to_i, search.to_d, search.to_d, search.to_d, search.to_d)
    
    search_multiple = Inventory.joins(:product).where('products.product_name IN (?) OR product_id 
                                              IN (?)', "%#{product_select}%", product_select)
    
    date_filter = Inventory.where("CAST(created_at AS DATE) >= '#{start_date.to_date}' 
                       AND CAST(created_at AS DATE) <= '#{end_date.to_date}'")
    

    if !start_date.blank? && !end_date.blank?
       date_filter
    end

    if product_select.blank? && search.blank?
      return Inventory.joins(:product).all     
    end

    if !search.blank?    
       return search_one
    elsif !product_select.blank?
      return search_multiple
    end
  end

  def self.current_inventory_for(product_id)
  	return Inventory.where("product_id = ? and current_amount_left > 0", product_id).sum(&:current_amount_left)
  end
  
  def set_costs  	
  	if self.current_amount_left == nil
  		self.current_amount_left = 0
  	end
    self.costs = self.amount * self.price_per_unit
    delta_of_purchased = self.amount - (self.amount_was || 0)
    self.current_amount_left = self.current_amount_left + delta_of_purchased   
  end
end