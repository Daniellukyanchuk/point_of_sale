require 'test_helper'

class OrderReportControllerTest < ActionDispatch::IntegrationTest
  test "should get client_report" do
    get order_report_client_report_url
    assert_response :success
  end

  test "should get product_report" do
    get order_report_product_report_url
    assert_response :success
  end

end
