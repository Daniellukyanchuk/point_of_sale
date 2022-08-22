require 'rails_helper'

RSpec.describe "employees/index", type: :view do
  before(:each) do
    assign(:employees, [
      Employee.create!(
        last_name: "Last Name",
        first_name: "First Name",
        middle_name: "Middle Name",
        phone: "Phone"
      ),
      Employee.create!(
        last_name: "Last Name",
        first_name: "First Name",
        middle_name: "Middle Name",
        phone: "Phone"
      )
    ])
  end

  it "renders a list of employees" do
    render
    assert_select "tr>td", text: "Last Name".to_s, count: 2
    assert_select "tr>td", text: "First Name".to_s, count: 2
    assert_select "tr>td", text: "Middle Name".to_s, count: 2
    assert_select "tr>td", text: "Phone".to_s, count: 2
  end
end
