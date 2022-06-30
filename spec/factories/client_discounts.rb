FactoryBot.define do
  factory :client_discount do
    discount_name { "MyString" }
    client_id { 1 }
    discount_per_unit { 1.5 }
    discounted_units { 1 }
    discounted_units_left { 1 }
    start_date { "2022-06-30" }
    end_date { "2022-06-30" }
  end
end
