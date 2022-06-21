require 'rails_helper'

RSpec.describe "discounts/show", type: :view do
  before(:each) do
    @discount = assign(:discount, Discount.create!(
      client_id: 2,
      discount_per_kilo: "9.99",
      experation_amount: "9.99"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/2/)
    expect(rendered).to match(/9.99/)
    expect(rendered).to match(/9.99/)
  end
end
