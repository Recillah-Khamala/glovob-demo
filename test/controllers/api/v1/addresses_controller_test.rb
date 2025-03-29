require "test_helper"

class Api::V1::AddressesControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get api_v1_addresses_index_url
    assert_response :success
  end

  test "should get create" do
    get api_v1_addresses_create_url
    assert_response :success
  end

  test "should get update" do
    get api_v1_addresses_update_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_addresses_destroy_url
    assert_response :success
  end
end
