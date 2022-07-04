require 'rails_helper'

RSpec.describe "order_product_discounts/show", type: :view do
  before(:each) do
    @order_product_discount = assign(:order_product_discount, OrderProductDiscount.create!(
      discount_id: 2,
      order_product_id: 3,
      discount_quantitu: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3/)
    expect(rendered).to match(/9.99/)
  end
end
