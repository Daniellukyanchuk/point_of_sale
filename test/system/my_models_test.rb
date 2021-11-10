require "application_system_test_case"

class MyModelsTest < ApplicationSystemTestCase
  setup do
    @my_model = my_models(:one)
  end

  test "visiting the index" do
    visit my_models_url
    assert_selector "h1", text: "My Models"
  end

  test "creating a My model" do
    visit my_models_url
    click_on "New My Model"

    click_on "Create My model"

    assert_text "My model was successfully created"
    click_on "Back"
  end

  test "updating a My model" do
    visit my_models_url
    click_on "Edit", match: :first

    click_on "Update My model"

    assert_text "My model was successfully updated"
    click_on "Back"
  end

  test "destroying a My model" do
    visit my_models_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "My model was successfully destroyed"
  end
end
