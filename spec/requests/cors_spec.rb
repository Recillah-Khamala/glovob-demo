require 'rails_helper'

RSpec.describe 'CORS Headers', type: :request do
  describe 'CORS preflight requests' do
    it 'allows OPTIONS requests from frontend origin' do
      options '/api/v1/offices',
             headers: {
               'Origin' => 'http://localhost:3001',
               'Access-Control-Request-Method' => 'GET',
               'Access-Control-Request-Headers' => 'Content-Type'
             }

      expect(response).to have_http_status(:ok)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('http://localhost:3001')
      expect(response.headers['Access-Control-Allow-Methods']).to include('GET')
    end

    it 'includes CORS headers in GET requests' do
      get '/api/v1/offices',
          headers: { 'Origin' => 'http://localhost:3001' }

      expect(response).to have_http_status(:ok)
      expect(response.headers['Access-Control-Allow-Origin']).to eq('http://localhost:3001')
    end

    it 'includes CORS headers in POST requests' do
      user = create(:user)
      office = create(:office)

      post '/api/v1/orders',
           params: {
             order: {
               user_id: user.id,
               office_id: office.id,
               package_description: 'Test package',
               weight: 10.5,
               delivery_address: '123 Test Street, Test City, 12345'
             }
           },
           headers: { 'Origin' => 'http://localhost:3001' }

      expect(response.headers['Access-Control-Allow-Origin']).to eq('http://localhost:3001')
    end
  end
end

