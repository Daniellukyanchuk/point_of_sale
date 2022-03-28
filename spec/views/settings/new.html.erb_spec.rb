require 'rails_helper'

RSpec.describe "settings/new", type: :view do
  before(:each) do
    assign(:setting, Setting.new(
      company_name: "MyString",
      company_address: "MyString",
      company_phone: "MyString"
    ))
  end

  it "renders new setting form" do
    render

    assert_select "form[action=?][method=?]", settings_path, "post" do

      assert_select "input[name=?]", "setting[company_name]"

      assert_select "input[name=?]", "setting[company_address]"

      assert_select "input[name=?]", "setting[company_phone]"
    end
  end
end
