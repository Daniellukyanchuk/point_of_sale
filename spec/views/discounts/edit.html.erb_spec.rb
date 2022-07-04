require 'rails_helper'

RSpec.describe "discounts/edit", type: :view do
  before(:each) do
    @discount = assign(:discount, Discount.create!(
      client_id: 1,
      discount_per_kilo: "9.99",
      experation_amount: "9.99"
    ))
  end

  it "renders the edit discount form" do
    render

    assert_select "form[action=?][method=?]", discount_path(@discount), "post" do

      assert_select "input[name=?]", "discount[client_id]"

      assert_select "input[name=?]", "discount[discount_per_kilo]"

      assert_select "input[name=?]", "discount[experation_amount]"
    end
  end
end
