require 'rails_helper'

RSpec.describe 'Order Workflow Integration', type: :request do
  let(:user) { create(:user) }
  let(:office) { create(:office) }

  describe 'Complete order lifecycle' do
    it 'allows creating an order and tracking it through status updates' do
      # Step 1: Create an order
      order_params = {
        order: {
          user_id: user.id,
          office_id: office.id,
          package_description: 'Integration test package',
          weight: 15.5,
          delivery_address: '456 Integration Street, Test City, 12345',
          estimated_cost: 50.00,
          estimated_time: 180
        }
      }

      post '/orders', params: order_params
      expect(response).to have_http_status(:created)
      
      json_response = JSON.parse(response.body)
      order_id = json_response['id']
      tracking_code = json_response['tracking_code']
      
      expect(tracking_code).to be_present
      expect(json_response['status']).to eq('pending')

      # Step 2: Retrieve the order
      get "/orders/#{order_id}"
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(order_id)
      expect(json_response['tracking_code']).to eq(tracking_code)

      # Step 3: Update status to picked
      patch "/orders/#{order_id}/status", params: { status: 'picked' }
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('picked')

      # Step 4: Update status to in_transit
      patch "/orders/#{order_id}/status", params: { status: 'in_transit' }
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('in_transit')

      # Step 5: Update status to delivered
      patch "/orders/#{order_id}/status", params: { status: 'delivered' }
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['status']).to eq('delivered')

      # Step 6: Verify order appears in user's order history
      get "/users/#{user.id}/orders"
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      order_ids = json_response.map { |o| o['id'] }
      expect(order_ids).to include(order_id)
      
      # Verify the order in the list has the correct status
      order_in_list = json_response.find { |o| o['id'] == order_id }
      expect(order_in_list['status']).to eq('delivered')
    end

    it 'allows retrieving office information for an order' do
      office = create(:office, name: 'Test Office')
      order = create(:order, user: user, office: office)

      # Get the order
      get "/orders/#{order.id}"
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['office']['id']).to eq(office.id)
      expect(json_response['office']['name']).to eq('Test Office')

      # Get the office directly
      get "/offices/#{office.id}"
      expect(response).to have_http_status(:ok)
      
      json_response = JSON.parse(response.body)
      expect(json_response['name']).to eq('Test Office')
    end
  end
end

