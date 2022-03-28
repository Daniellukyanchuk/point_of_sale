require 'rails_helper'

RSpec.describe "settings/show", type: :view do
  before(:each) do
    @setting = assign(:setting, Setting.create!(
      company_name: "Company Name",
      company_address: "Company Address",
      company_phone: "Company Phone"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Company Name/)
    expect(rendered).to match(/Company Address/)
    expect(rendered).to match(/Company Phone/)
  end
end
