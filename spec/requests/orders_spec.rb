require 'rails_helper'

RSpec.describe 'Orders API', type: :request do
  let(:user) { create(:user) }
  let(:office) { create(:office) }

  describe 'POST /orders' do
    let(:valid_params) do
      {
        order: {
          user_id: user.id,
          office_id: office.id,
          package_description: 'Test package description',
          weight: 10.5,
          delivery_address: '123 Test Street, Test City, 12345',
          estimated_cost: 25.50,
          estimated_time: 120
        }
      }
    end

    let(:invalid_params) do
      {
        order: {
          user_id: user.id,
          office_id: office.id,
          package_description: 'AB', # Too short
          weight: -5, # Invalid
          delivery_address: 'Short' # Too short
        }
      }
    end

    context 'with valid parameters' do
      it 'creates a new order' do
        expect {
          post '/orders', params: valid_params
        }.to change(Order, :count).by(1)

        expect(response).to have_http_status(:created)
        json_response = JSON.parse(response.body)
        expect(json_response['package_description']).to eq('Test package description')
        expect(json_response['tracking_code']).to be_present
      end

      it 'generates a tracking code automatically' do
        post '/orders', params: valid_params
        
        json_response = JSON.parse(response.body)
        expect(json_response['tracking_code']).to start_with('GLV')
      end
    end

    context 'with invalid parameters' do
      it 'returns unprocessable entity status' do
        post '/orders', params: invalid_params
        
        expect(response).to have_http_status(:unprocessable_entity)
        json_response = JSON.parse(response.body)
        expect(json_response['errors']).to be_present
      end
    end
  end

  describe 'GET /orders/:id' do
    let!(:order) { create(:order, user: user, office: office) }

    it 'returns order details' do
      get "/orders/#{order.id}"
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(order.id)
      expect(json_response['tracking_code']).to eq(order.tracking_code)
    end

    it 'returns 404 for non-existent order' do
      get '/orders/99999'
      
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Order not found')
    end
  end

  describe 'PATCH /orders/:id/status' do
    let!(:order) { create(:order, user: user, office: office, status: :pending) }

    context 'with valid status' do
      it 'updates order status' do
        patch "/orders/#{order.id}/status", params: { status: 'picked' }
        
        expect(response).to have_http_status(:ok)
        json_response = JSON.parse(response.body)
        expect(json_response['status']).to eq('picked')
        expect(order.reload.status).to eq('picked')
      end

      it 'allows status transitions' do
        patch "/orders/#{order.id}/status", params: { status: 'in_transit' }
        expect(response).to have_http_status(:ok)
        
        patch "/orders/#{order.id}/status", params: { status: 'delivered' }
        expect(response).to have_http_status(:ok)
        expect(order.reload.status).to eq('delivered')
      end
    end

    context 'with invalid status' do
      it 'returns unprocessable entity' do
        patch "/orders/#{order.id}/status", params: { status: 'invalid_status' }
        
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end
end

