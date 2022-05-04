require 'rails_helper'

RSpec.describe "product_categories/edit", type: :view do
  before(:each) do
    @product_category = assign(:product_category, ProductCategory.create!(
      category_name: "MyString",
      category_description: "MyText"
    ))
  end

  it "renders the edit product_category form" do
    render

    assert_select "form[action=?][method=?]", product_category_path(@product_category), "post" do

      assert_select "input[name=?]", "product_category[category_name]"

      assert_select "textarea[name=?]", "product_category[category_description]"
    end
  end
end
