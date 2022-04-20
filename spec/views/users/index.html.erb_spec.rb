require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        user_name: "User Name",
        user_email: "User Email"
      ),
      User.create!(
        user_name: "User Name",
        user_email: "User Email"
      )
    ])
  end

  it "renders a list of users" do
    render
    assert_select "tr>td", text: "User Name".to_s, count: 2
    assert_select "tr>td", text: "User Email".to_s, count: 2
  end
end
