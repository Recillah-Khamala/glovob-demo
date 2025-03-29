require "test_helper"

module Api
  module V1
    class AddressesControllerTest < ActionDispatch::IntegrationTest
      setup do
        @user = users(:one) # Assuming you have a fixture
        @address = addresses(:one) # Assuming you have a fixture
        sign_in @user # Assuming you have a test helper method for this
      end

      test "should get index" do
        get api_v1_addresses_url

        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal 'success', json_response['status']
        assert_kind_of Array, json_response['data']['addresses']
      end

      test "should create address" do
        assert_difference('Address.count') do
          post api_v1_addresses_url, params: {
            address: {
              street: '123 Main St',
              city: 'New City',
              state: 'New State',
              postal_code: '12345',
              country: 'New Country',
              building_or_estate_name: 'Building A',
              house_number_or_name: 'Unit 1'
            }
          }, as: :json
        end

        assert_response :created
        json_response = JSON.parse(response.body)
        assert_equal 'success', json_response['status']
        assert_equal '123 Main St', json_response['data']['address']['street']
      end

      test "should update address" do
        patch api_v1_address_url(@address), params: {
          address: {
            street: '456 New St'
          }
        }, as: :json

        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal 'success', json_response['status']
        assert_equal '456 New St', json_response['data']['address']['street']
      end

      test "should destroy address" do
        assert_difference('Address.count', -1) do
          delete api_v1_address_url(@address)
        end

        assert_response :success
        json_response = JSON.parse(response.body)
        assert_equal 'success', json_response['status']
      end

      test "should not update address with invalid params" do
        patch api_v1_address_url(@address), params: {
          address: {
            street: '' # Empty street is invalid
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
