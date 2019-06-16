require 'rails_helper'

RSpec.describe Api::V1::UsersController, type: :controller do
  describe 'GET #index' do
    let!(:user) { create(:user) }
    let!(:user2) { create(:user) }
    let(:headers) { valid_headers }

    before do
      request.headers.merge! headers
      get :index
    end

    it 'returns all users' do
      users = JSON.parse(response.body)
      expect(users.count).to eq 2
      expect(users.first['email']).to eq user.email
      expect(users.last['email']).to eq user2.email
    end

    it 'returns http status 200' do
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'POST #create sign_up' do
    let(:user) { build(:user) }
    let(:valid_credentials) do
      {
        email: user.email,
        password: user.password
      }
    end

    context 'when valid request' do
      before { post(:create, params: valid_credentials) }

      it 'creates a new user' do
        expect(response).to have_http_status(201)
      end

      it 'returns success message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eq 'User created successfully'
      end

      it 'returns an authentication token' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['access_token']).to be
      end
    end

    context 'when invalid request' do
      before { post :create, params: {} }

      it 'does not create a new user' do
        expect(response).to have_http_status(422)
      end

      it 'returns failure message about missing password' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['password'])
          .to include(
            "can't be blank",
            'is too short (minimum is 8 characters)'
          )
      end

      it 'returns failure message about missing email' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['email'])
          .to include(
            "can't be blank",
            'is invalid'
          )
      end
    end
  end
end
