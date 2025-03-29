ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    # Add more helper methods to be used by all tests here...
    def sign_in(user)
      post api_v1_auth_login_url, params: {
        email: user.email,
        password: 'password123'
      }, as: :json
    end

    def auth_headers
      {
        'Authorization' => "Bearer #{response.headers['Authorization']}"
      }
    end
  end
end
