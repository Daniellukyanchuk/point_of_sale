json.extract! employee, :id, :last_name, :first_name, :middle_name, :phone, :hire_date, :created_at, :updated_at
json.url employee_url(employee, format: :json)
