require 'rails_helper'

RSpec.describe "product_categories/index", type: :view do
  before(:each) do
    assign(:product_categories, [
      ProductCategory.create!(
        category_name: "Category Name",
        category_description: "MyText"
      ),
      ProductCategory.create!(
        category_name: "Category Name",
        category_description: "MyText"
      )
    ])
  end

  it "renders a list of product_categories" do
    render
    assert_select "tr>td", text: "Category Name".to_s, count: 2
    assert_select "tr>td", text: "MyText".to_s, count: 2
  end
end
