require 'rails_helper'

RSpec.describe "employees/edit", type: :view do
  before(:each) do
    @employee = assign(:employee, Employee.create!(
      last_name: "MyString",
      first_name: "MyString",
      middle_name: "MyString",
      phone: "MyString"
    ))
  end

  it "renders the edit employee form" do
    render

    assert_select "form[action=?][method=?]", employee_path(@employee), "post" do

      assert_select "input[name=?]", "employee[last_name]"

      assert_select "input[name=?]", "employee[first_name]"

      assert_select "input[name=?]", "employee[middle_name]"

      assert_select "input[name=?]", "employee[phone]"
    end
  end
end
