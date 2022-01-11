require "application_system_test_case"

class InventoriesTest < ApplicationSystemTestCase
  setup do
    @inventory = inventories(:one)
  end

  test "visiting the index" do
    visit inventories_url
    assert_selector "h1", text: "Inventory Records"
  end

  test "creating a Inventory record" do
    visit inventories_url
    click_on "New Inventory Record"

    click_on "Create Inventory record"

    assert_text "Inventory record was successfully created"
    click_on "Back"
  end

  test "updating a Inventory record" do
    visit inventories_url
    click_on "Edit", match: :first

    click_on "Update Inventory record"

    assert_text "Inventory record was successfully updated"
    click_on "Back"
  end

  test "destroying a Inventory record" do
    visit inventories_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Inventory record was successfully destroyed"
  end
end
