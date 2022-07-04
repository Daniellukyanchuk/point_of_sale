FactoryBot.define do
  factory :discount do
    client_id { 1 }
    discount_per_kilo { "9.99" }
    experation_amount { "9.99" }
    starting_date { "2022-06-20" }
    ending_date { "2022-06-20" }
  end
end
