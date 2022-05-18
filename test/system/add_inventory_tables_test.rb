require "application_system_test_case"

class AddInventoryTablesTest < ApplicationSystemTestCase
  setup do
    @add_inventory_table = add_inventory_tables(:one)
  end

  test "visiting the index" do
    visit add_inventory_tables_url
    assert_selector "h1", text: "Add Inventory Tables"
  end

  test "creating a Add inventory table" do
    visit add_inventory_tables_url
    click_on "New Add Inventory Table"

    click_on "Create Add inventory table"

    assert_text "Add inventory table was successfully created"
    click_on "Back"
  end

  test "updating a Add inventory table" do
    visit add_inventory_tables_url
    click_on "Edit", match: :first

    click_on "Update Add inventory table"

    assert_text "Add inventory table was successfully updated"
    click_on "Back"
  end

  test "destroying a Add inventory table" do
    visit add_inventory_tables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Add inventory table was successfully destroyed"
  end
end
