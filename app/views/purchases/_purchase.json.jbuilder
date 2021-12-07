json.extract! purchase, :id, :supplier_id, :date_of_the_order, :expected_date_of_delivery, :estimated_total, :actual_total, :created_at, :updated_at
json.url purchase_url(purchase, format: :json)
