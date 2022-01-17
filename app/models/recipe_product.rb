class RecipeProduct < ApplicationRecord
  belongs_to :recipe
  belongs_to :product
  validates :product_amount, :product_price, presence: true
  

  def set_product_subtotals  
    self.product_subtotal = product_amount * product_price
  end
end