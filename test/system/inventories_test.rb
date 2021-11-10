require "application_system_test_case"

class InventoriesTest < ApplicationSystemTestCase
  setup do
    @inventory = inventories(:one)
  end

  test "visiting the index" do
    visit inventories_url
    assert_selector "h1", text: "Inventories"
  end

  test "creating a Inventory" do
    visit inventories_url
    click_on "New Inventory"

    fill_in "Amount", with: @inventory.amount
    fill_in "Costs", with: @inventory.costs
    fill_in "Current amount left", with: @inventory.current_amount_left
    fill_in "Date", with: @inventory.date
    fill_in "Price per unit", with: @inventory.price_per_unit
    fill_in "Product", with: @inventory.product_id
    fill_in "Value of item", with: @inventory.value_of_item
    click_on "Create Inventory"

    assert_text "Inventory was successfully created"
    click_on "Back"
  end

  test "updating a Inventory" do
    visit inventories_url
    click_on "Edit", match: :first

    fill_in "Amount", with: @inventory.amount
    fill_in "Costs", with: @inventory.costs
    fill_in "Current amount left", with: @inventory.current_amount_left
    fill_in "Date", with: @inventory.date
    fill_in "Price per unit", with: @inventory.price_per_unit
    fill_in "Product", with: @inventory.product_id
    fill_in "Value of item", with: @inventory.value_of_item
    click_on "Update Inventory"

    assert_text "Inventory was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory" do
    visit inventories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory was successfully destroyed"
  end
end
