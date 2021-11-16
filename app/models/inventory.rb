class Inventory < ApplicationRecord
  belongs_to :product
  before_save :set_costs
  belongs_to :order_product

  def self.search(search, product_select, start_date, end_date)

    where_sql = "product_id = :product_id and from_date > :start_date"
    where_params = {product_id: 3}
    where_params[:start_date] = start_date.to_date

    Inventory.where(where_sql, where_params)
    if !search.blank?	  
	  return Inventory.joins(:product)
	  .where("products.product_name ilike ? 
	  		  or product_id = ? or amount = ? 
	  		  or price_per_unit = ? or costs = ? 
	  		  or current_amount_left = ?", "%#{search.strip}%", search.to_i, search.to_d, search.to_d, search.to_d, search.to_d)
	else
	  return Inventory.joins(:product).all
	end
  end
# Make a where clause that has all the params in it.

# def self.product_select(product_select)
#   if !product_select.blank?
#   	return Inventory.joins(:product).where('products.product_name IN (?) OR product_id IN (?)', "%#{product_select}%", product_select)	  	
#   else 
#   	return Inventory.joins(:product).all		
#   end
# end
   
  def self.date_picker(start_date, end_date)
    if !date_picker.blank?
      Inventory.where("CAST(created_at AS DATE) >= #{SqlHelper.escape_sql_param(start_date.to_date)} AND CAST(created_at AS DATE) <= #{SqlHelper.escape_sql_param(end_date.to_date)}") 
    else 
      Inventory.where(:created_at => start_date..end_date) 
    end
  end

  def set_current_amount_left
  	self.current_amount_left = self.current_amount_left + self.amount
  end

  def set_costs
    self.costs = self.amount * self.price_per_unit
  end
end