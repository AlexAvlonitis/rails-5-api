require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #index" do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let(:headers) { valid_headers }

    before do
      request.headers.merge! headers
      get :index
    end

    it "returns all users" do
      users = JSON.parse(response.body)
      expect(users.count).to eq 2
      expect(users.first['email']).to eq user.email
      expect(users.last['email']).to eq user2.email
    end

    it 'returns http status 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
