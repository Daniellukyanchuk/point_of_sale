FactoryBot.define do
  factory :order_product_discount do
    discount_id { 1 }
    order_product_id { 1 }
    discount_quantitu { "9.99" }
  end
end
