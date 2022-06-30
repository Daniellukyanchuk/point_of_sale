require 'rails_helper'

RSpec.describe "client_discounts/index", type: :view do
  before(:each) do
    assign(:client_discounts, [
      ClientDiscount.create!(
        discount_name: "Discount Name",
        client_id: 2,
        discount_per_unit: 3.5,
        discounted_units: 4,
        discounted_units_left: 5
      ),
      ClientDiscount.create!(
        discount_name: "Discount Name",
        client_id: 2,
        discount_per_unit: 3.5,
        discounted_units: 4,
        discounted_units_left: 5
      )
    ])
  end

  it "renders a list of client_discounts" do
    render
    assert_select "tr>td", text: "Discount Name".to_s, count: 2
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.5.to_s, count: 2
    assert_select "tr>td", text: 4.to_s, count: 2
    assert_select "tr>td", text: 5.to_s, count: 2
  end
end
