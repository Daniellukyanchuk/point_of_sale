require 'rails_helper'

RSpec.describe "product_categories/show", type: :view do
  before(:each) do
    @product_category = assign(:product_category, ProductCategory.create!(
      category_name: "Category Name",
      category_description: "MyText"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Category Name/)
    expect(rendered).to match(/MyText/)
  end
end
