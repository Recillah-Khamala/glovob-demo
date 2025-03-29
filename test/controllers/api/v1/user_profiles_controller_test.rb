require "test_helper"

module Api
  module V1
    class UserProfilesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one) # Assuming you have a fixture
        sign_in @user # Assuming you have a test helper method for this
      end

      test "should get profile" do
        get api_v1_profile_url

        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal 'success', json_response['status']
        assert_equal @user.email, json_response['data']['user']['email']
      end

      test "should update profile" do
        patch api_v1_profile_url, params: {
          user: {
            first_name: 'New Name',
            last_name: 'New Last Name'
          }
        }, as: :json

        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal 'success', json_response['status']
        assert_equal 'New Name', json_response['data']['user']['first_name']
        assert_equal 'New Last Name', json_response['data']['user']['last_name']
      end

      test "should not update profile with invalid params" do
        patch api_v1_profile_url, params: {
          user: {
            email: 'invalid_email'
          }
        }, as: :json

        assert_response :unprocessable_entity
        json_response = JSON.parse(response.body)
        assert_equal 'error', json_response['status']
        assert_not_empty json_response['errors']
      end
    end
  end
end
