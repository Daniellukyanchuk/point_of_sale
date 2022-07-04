require 'rails_helper'

RSpec.describe "order_product_discounts/edit", type: :view do
  before(:each) do
    @order_product_discount = assign(:order_product_discount, OrderProductDiscount.create!(
      discount_id: 1,
      order_product_id: 1,
      discount_quantitu: "9.99"
    ))
  end

  it "renders the edit order_product_discount form" do
    render

    assert_select "form[action=?][method=?]", order_product_discount_path(@order_product_discount), "post" do

      assert_select "input[name=?]", "order_product_discount[discount_id]"

      assert_select "input[name=?]", "order_product_discount[order_product_id]"

      assert_select "input[name=?]", "order_product_discount[discount_quantitu]"
    end
  end
end
