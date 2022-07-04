require 'rails_helper'

RSpec.describe "order_product_discounts/index", type: :view do
  before(:each) do
    assign(:order_product_discounts, [
      OrderProductDiscount.create!(
        discount_id: 2,
        order_product_id: 3,
        discount_quantitu: "9.99"
      ),
      OrderProductDiscount.create!(
        discount_id: 2,
        order_product_id: 3,
        discount_quantitu: "9.99"
      )
    ])
  end

  it "renders a list of order_product_discounts" do
    render
    assert_select "tr>td", text: 2.to_s, count: 2
    assert_select "tr>td", text: 3.to_s, count: 2
    assert_select "tr>td", text: "9.99".to_s, count: 2
  end
end
