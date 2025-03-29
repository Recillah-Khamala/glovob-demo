require "test_helper"

class Api::V1::Auth::SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_auth_sessions_create_url
    assert_response :success
  end

  test "should get destroy" do
    get api_v1_auth_sessions_destroy_url
    assert_response :success
  end
end
