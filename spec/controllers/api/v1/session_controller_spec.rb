require 'rails_helper'

RSpec.describe Api::V1::SessionsController, type: :request do
  describe 'POST /api/user/sign_in' do
    let!(:user) { create(:user) }
    let(:headers) { valid_headers.except('Authorization') }

    let(:valid_credentials) do
      {
        user: {
          email: user.email,
          password: user.password
        }
      }.to_json
    end

    let(:invalid_credentials) do
      {
        user: {
          email: Faker::Internet.email,
          password: Faker::Internet.password
        }
      }.to_json
    end

    context 'When request is valid' do
      before do
        post '/api/user/sign_in', params: valid_credentials, headers: headers
      end

      it 'returns an authentication token' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['message']).to eq "Login Successful"
      end
    end

    context 'When request is invalid' do
      before do
        post '/api/user/sign_in', params: invalid_credentials, headers: headers
      end

      it 'returns a failure message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body.dig('error', 'user_authentication'))
          .to include "Invalid credentials"
      end
    end
  end
end
