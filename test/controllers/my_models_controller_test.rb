require 'test_helper'

class MyModelsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @my_model = my_models(:one)
  end

  test "should get index" do
    get my_models_url
    assert_response :success
  end

  test "should get new" do
    get new_my_model_url
    assert_response :success
  end

  test "should create my_model" do
    assert_difference('MyModel.count') do
      post my_models_url, params: { my_model: {  } }
    end

    assert_redirected_to my_model_url(MyModel.last)
  end

  test "should show my_model" do
    get my_model_url(@my_model)
    assert_response :success
  end

  test "should get edit" do
    get edit_my_model_url(@my_model)
    assert_response :success
  end

  test "should update my_model" do
    patch my_model_url(@my_model), params: { my_model: {  } }
    assert_redirected_to my_model_url(@my_model)
  end

  test "should destroy my_model" do
    assert_difference('MyModel.count', -1) do
      delete my_model_url(@my_model)
    end

    assert_redirected_to my_models_url
  end
end
