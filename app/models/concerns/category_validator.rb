class CategoryValidator < ActiveModel::Validator
    def has_product_category
        stop
        if category_products.ids.blank?
          errors.add(:category_id, "No product category chosen!")
        end
    end
end