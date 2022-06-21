require 'rails_helper'

RSpec.describe "discounts/new", type: :view do
  before(:each) do
    assign(:discount, Discount.new(
      client_id: 1,
      discount_per_kilo: "9.99",
      experation_amount: "9.99"
    ))
  end

  it "renders new discount form" do
    render

    assert_select "form[action=?][method=?]", discounts_path, "post" do

      assert_select "input[name=?]", "discount[client_id]"

      assert_select "input[name=?]", "discount[discount_per_kilo]"

      assert_select "input[name=?]", "discount[experation_amount]"
    end
  end
end
