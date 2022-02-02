

class Inventory < ApplicationRecord
	belongs_to :purchase_product
  belongs_to :product
  belongs_to :purchase
	before_create :set_remaining_quantity

  attr_accessor :purchase_quantity

  def set_remaining_quantity

        if self.purchase_quantity.blank?
            self.remaining_quantity = nil
        else
            self.remaining_quantity = purchase_quantity
        end
    end

  # takes an array of product_ids and returns a hash of the amount left in inventory
  def self.get_amounts_for(product_ids)

    sql = """
            SELECT product_id, (remaining_quantity*grams_per_unit) AS amount_available_in_grams
            FROM inventories 
            INNER JOIN products ON product_id = products.id
            WHERE product_id IN (#{SqlHelper.escape_sql_param product_ids})
          
          """

    results = ActiveRecord::Base.connection.execute(sql)  
    amounts_left = {}
    results.each do |row|
      amounts_left[row['product_id'].to_i] = row['amount_available_in_grams']
    end
end

def self.add_inventory(production_id, product_id, remaining_quantity)
    Inventory.create(:id, :production_id, :product_id, :remaining_quantity)
end

def create
  puppies_array = puppies_params[:puppies].collect do |puppy|
                    puppy[:puppy]
                  end
  Puppy.create(puppies_array)
end


  def self.search(search)
    if !search.blank?
        return Inventory.where("id = ? or product_id = ? or purchase_order_id = ? or purchase_order_product_id = ?", "%#{search.strip}%", "%#{search.strip}%", search.to_i)
    else
    Inventory.all
    end
  end

  def self.remove_inventory(product_id, usage_amount)
    
      return if usage_amount.nil? || usage_amount == 0

      inventories = Inventory.where("product_id = ? and remaining_quantity > 0", product_id).order("created_at asc")
      amount_left_to_remove = usage_amount

      inventories.each do |sp|
          #converts remaining units to remaining grams
          sp.remaining_quantity = sp.remaining_quantity * sp.product.grams_per_unit
          #sets remaining amount equalt to remaining amount for the oldest record in the database
          amount_to_remove = [amount_left_to_remove, sp.remaining_quantity].min
          #calculates how much needs to be subracted from the next record, if any
          amount_left_to_remove = amount_left_to_remove - amount_to_remove
          #subtracts inventory from the current record 
          sp.remaining_quantity = sp.remaining_quantity - amount_to_remove
          #convert remaining grams back to remaining units
          sp.remaining_quantity = sp.remaining_quantity/sp.product.grams_per_unit 
          sp.save! #saves result to database
          break amount_left_to_remove == 0
      end 

      return amount_left_to_remove
      alert("Insuficient Inventory")
  end

end
