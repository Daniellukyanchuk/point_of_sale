require 'rails_helper'

RSpec.describe "roles/index", type: :view do
  before(:each) do
    assign(:roles, [
      Role.create!(
        role_name: "Role Name"
      ),
      Role.create!(
        role_name: "Role Name"
      )
    ])
  end

  it "renders a list of roles" do
    render
    assert_select "tr>td", text: "Role Name".to_s, count: 2
  end
end
