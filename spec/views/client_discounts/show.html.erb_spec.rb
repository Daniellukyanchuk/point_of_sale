require 'rails_helper'

RSpec.describe "client_discounts/show", type: :view do
  before(:each) do
    @client_discount = assign(:client_discount, ClientDiscount.create!(
      discount_name: "Discount Name",
      client_id: 2,
      discount_per_unit: 3.5,
      discounted_units: 4,
      discounted_units_left: 5
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Discount Name/)
    expect(rendered).to match(/2/)
    expect(rendered).to match(/3.5/)
    expect(rendered).to match(/4/)
    expect(rendered).to match(/5/)
  end
end
