require "application_system_test_case"

class purchasesTest < ApplicationSystemTestCase
  setup do
    @purchase = purchases(:one)
  end

  test "visiting the index" do
    visit purchases_url
    assert_selector "h1", text: "purchases"
  end

  test "creating a purchase" do
    visit purchases_url
    click_on "New purchase"

    click_on "Create purchase"

    assert_text "purchase was successfully created"
    click_on "Back"
  end

  test "updating a purchase" do
    visit purchases_url
    click_on "Edit", match: :first

    click_on "Update purchase"

    assert_text "purchase was successfully updated"
    click_on "Back"
  end

  test "destroying a purchase" do
    visit purchases_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "purchase was successfully destroyed"
  end
end
