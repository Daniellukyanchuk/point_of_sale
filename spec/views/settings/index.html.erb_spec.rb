require 'rails_helper'

RSpec.describe "settings/index", type: :view do
  before(:each) do
    assign(:settings, [
      Setting.create!(
        company_name: "Company Name",
        company_address: "Company Address",
        company_phone: "Company Phone"
      ),
      Setting.create!(
        company_name: "Company Name",
        company_address: "Company Address",
        company_phone: "Company Phone"
      )
    ])
  end

  it "renders a list of settings" do
    render
    assert_select "tr>td", text: "Company Name".to_s, count: 2
    assert_select "tr>td", text: "Company Address".to_s, count: 2
    assert_select "tr>td", text: "Company Phone".to_s, count: 2
  end
end
