require "test_helper"

class Api::V1::Auth::RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get api_v1_auth_registrations_create_url
    assert_response :success
  end
end
