require 'rails_helper'

RSpec.describe "settings/edit", type: :view do
  before(:each) do
    @setting = assign(:setting, Setting.create!(
      company_name: "MyString",
      company_address: "MyString",
      company_phone: "MyString"
    ))
  end

  it "renders the edit setting form" do
    render

    assert_select "form[action=?][method=?]", setting_path(@setting), "post" do

      assert_select "input[name=?]", "setting[company_name]"

      assert_select "input[name=?]", "setting[company_address]"

      assert_select "input[name=?]", "setting[company_phone]"
    end
  end
end
