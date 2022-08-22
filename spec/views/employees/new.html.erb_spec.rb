require 'rails_helper'

RSpec.describe "employees/new", type: :view do
  before(:each) do
    assign(:employee, Employee.new(
      last_name: "MyString",
      first_name: "MyString",
      middle_name: "MyString",
      phone: "MyString"
    ))
  end

  it "renders new employee form" do
    render

    assert_select "form[action=?][method=?]", employees_path, "post" do

      assert_select "input[name=?]", "employee[last_name]"

      assert_select "input[name=?]", "employee[first_name]"

      assert_select "input[name=?]", "employee[middle_name]"

      assert_select "input[name=?]", "employee[phone]"
    end
  end
end
