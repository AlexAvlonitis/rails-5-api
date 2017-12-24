require 'rails_helper'

RSpec.describe Auth::AuthenticateUser do
  let(:user) { create(:user) }
  let(:user_attributes) { attributes_for(:user) }
  subject(:valid_auth_obj) { described_class.new(user_attributes) }
  subject(:invalid_auth_obj) do
    described_class.new(email: 'foo', password: 'bar')
  end

  describe '#call' do
    context 'when valid credentials' do
      it 'returns an auth token' do
        auth_user = valid_auth_obj.call
        expect(auth_user).to be_an_instance_of Auth::AuthenticateUser
      end
    end

    context 'when invalid credentials' do
      it 'raises an authentication error' do
        auth_user = invalid_auth_obj.call
        expect(auth_user.errors[:user_authentication])
          .to include /Invalid credentials/
      end
    end
  end
end
