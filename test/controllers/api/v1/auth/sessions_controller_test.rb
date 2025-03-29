require "test_helper"

module Api
  module V1
    module Auth
      class SessionsControllerTest < ActionDispatch::IntegrationTest
        setup do
          @user = users(:one) # Assuming you have a fixture
        end

        test "should login with valid credentials" do
          post api_v1_auth_login_url, params: {
            email: @user.email,
            password: 'password123' # Assuming this is the password in your fixture
          }, as: :json

          assert_response :success
          json_response = JSON.parse(response.body)
          assert_equal 'success', json_response['status']
          assert_equal @user.email, json_response['data']['user']['email']
        end

        test "should not login with invalid credentials" do
          post api_v1_auth_login_url, params: {
            email: @user.email,
            password: 'wrong_password'
          }, as: :json

          assert_response :unauthorized
          json_response = JSON.parse(response.body)
          assert_equal 'error', json_response['status']
        end

        test "should logout user" do
          sign_in @user # Assuming you have a test helper method for this
          delete api_v1_auth_logout_url

          assert_response :success
          json_response = JSON.parse(response.body)
          assert_equal 'success', json_response['status']
        end
      end
    end
  end
end
