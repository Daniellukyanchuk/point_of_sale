require 'test_helper'

class InventoryRecordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @inventory_record = inventory_records(:one)
  end

  test "should get index" do
    get inventory_records_url
    assert_response :success
  end

  test "should get new" do
    get new_inventory_record_url
    assert_response :success
  end

  test "should create inventory_record" do
    assert_difference('InventoryRecord.count') do
      post inventory_records_url, params: { inventory_record: {  } }
    end

    assert_redirected_to inventory_record_url(InventoryRecord.last)
  end

  test "should show inventory_record" do
    get inventory_record_url(@inventory_record)
    assert_response :success
  end

  test "should get edit" do
    get edit_inventory_record_url(@inventory_record)
    assert_response :success
  end

  test "should update inventory_record" do
    patch inventory_record_url(@inventory_record), params: { inventory_record: {  } }
    assert_redirected_to inventory_record_url(@inventory_record)
  end

  test "should destroy inventory_record" do
    assert_difference('InventoryRecord.count', -1) do
      delete inventory_record_url(@inventory_record)
    end

    assert_redirected_to inventory_records_url
  end
end
