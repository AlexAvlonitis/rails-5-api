require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe "GET #index" do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }

    before { get :index }

    it "returns all users" do
      users = JSON.parse(response.body)
      expect(users.count).to eq 2
      expect(users.first['id']).to eq user['id']
      expect(users.last['id']).to eq user2['id']
    end

    it 'returns http status 200' do
      expect(response).to have_http_status(:ok)
    end
  end
end
