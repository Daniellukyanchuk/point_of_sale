class CategoryProduct < ApplicationRecord
    belongs_to :product
    belongs_to :product_category
    validate :has_product_category

    def has_product_category
        stop
        if category_products.ids.blank?
          errors.add(:category_id, "No product category chosen!")
        end
      end

end
