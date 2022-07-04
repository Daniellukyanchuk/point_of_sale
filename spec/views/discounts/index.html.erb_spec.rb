require 'rails_helper'

RSpec.describe "discounts/index", type: :view do
  before(:each) do
    assign(:discounts, [
      Discount.create!(
        client_id: 2,
        discount_per_kilo: "9.99",
        experation_amount: "9.99"
      ),
      Discount.create!(
        client_id: 2,
        discount_per_kilo: "9.99",
        experation_amount: "9.99"
      )
    ])
  end

  it "renders a list of discounts" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
