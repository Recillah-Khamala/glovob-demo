require 'rails_helper'

RSpec.describe 'Users API', type: :request do
  let(:user) { create(:user) }
  let(:office) { create(:office) }

  describe 'GET /users/:id/orders' do
    let!(:order1) { create(:order, user: user, office: office) }
    let!(:order2) { create(:order, user: user, office: office) }
    let!(:other_user_order) { create(:order, office: office) }

    it 'returns all orders for a specific user' do
      get "/users/#{user.id}/orders"
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
      expect(json_response.map { |o| o['id'] }).to contain_exactly(order1.id, order2.id)
    end

    it 'does not return orders from other users' do
      get "/users/#{user.id}/orders"
      
      json_response = JSON.parse(response.body)
      order_ids = json_response.map { |o| o['id'] }
      expect(order_ids).not_to include(other_user_order.id)
    end

    it 'returns orders ordered by created_at desc' do
      get "/users/#{user.id}/orders"
      
      json_response = JSON.parse(response.body)
      expect(json_response.first['id']).to eq(order2.id)
      expect(json_response.second['id']).to eq(order1.id)
    end

    it 'returns 404 for non-existent user' do
      get '/users/99999/orders'
      
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('User not found')
    end

    it 'returns empty array for user with no orders' do
      new_user = create(:user)
      get "/users/#{new_user.id}/orders"
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response).to eq([])
    end
  end
end

