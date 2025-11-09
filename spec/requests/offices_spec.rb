require 'rails_helper'

RSpec.describe 'Offices API', type: :request do
  describe 'GET /api/v1/offices' do
    let!(:office1) { create(:office) }
    let!(:office2) { create(:office) }

    it 'returns all offices' do
      get '/api/v1/offices'
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response.length).to eq(2)
    end

    it 'returns offices with correct structure' do
      get '/api/v1/offices'
      
      json_response = JSON.parse(response.body)
      expect(json_response.first).to include('id', 'name', 'location', 'contact_info')
    end
  end

  describe 'GET /api/v1/offices/:id' do
    let!(:office) { create(:office) }

    it 'returns a specific office' do
      get "/api/v1/offices/#{office.id}"
      
      expect(response).to have_http_status(:ok)
      json_response = JSON.parse(response.body)
      expect(json_response['id']).to eq(office.id)
      expect(json_response['name']).to eq(office.name)
    end

    it 'returns 404 for non-existent office' do
      get '/api/v1/offices/99999'
      
      expect(response).to have_http_status(:not_found)
      json_response = JSON.parse(response.body)
      expect(json_response['error']).to eq('Office not found')
    end
  end
end

