require 'rails_helper'

RSpec.describe "client_discounts/edit", type: :view do
  before(:each) do
    @client_discount = assign(:client_discount, ClientDiscount.create!(
      discount_name: "MyString",
      client_id: 1,
      discount_per_unit: 1.5,
      discounted_units: 1,
      discounted_units_left: 1
    ))
  end

  it "renders the edit client_discount form" do
    render

    assert_select "form[action=?][method=?]", client_discount_path(@client_discount), "post" do

      assert_select "input[name=?]", "client_discount[discount_name]"

      assert_select "input[name=?]", "client_discount[client_id]"

      assert_select "input[name=?]", "client_discount[discount_per_unit]"

      assert_select "input[name=?]", "client_discount[discounted_units]"

      assert_select "input[name=?]", "client_discount[discounted_units_left]"
    end
  end
end
