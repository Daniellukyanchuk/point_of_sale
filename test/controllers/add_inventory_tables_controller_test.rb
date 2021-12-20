require 'test_helper'

class AddInventoryTablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_inventory_table = add_inventory_tables(:one)
  end

  test "should get index" do
    get add_inventory_tables_url
    assert_response :success
  end

  test "should get new" do
    get new_add_inventory_table_url
    assert_response :success
  end

  test "should create add_inventory_table" do
    assert_difference('AddInventoryTable.count') do
      post add_inventory_tables_url, params: { add_inventory_table: {  } }
    end

    assert_redirected_to add_inventory_table_url(AddInventoryTable.last)
  end

  test "should show add_inventory_table" do
    get add_inventory_table_url(@add_inventory_table)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_inventory_table_url(@add_inventory_table)
    assert_response :success
  end

  test "should update add_inventory_table" do
    patch add_inventory_table_url(@add_inventory_table), params: { add_inventory_table: {  } }
    assert_redirected_to add_inventory_table_url(@add_inventory_table)
  end

  test "should destroy add_inventory_table" do
    assert_difference('AddInventoryTable.count', -1) do
      delete add_inventory_table_url(@add_inventory_table)
    end

    assert_redirected_to add_inventory_tables_url
  end
end
