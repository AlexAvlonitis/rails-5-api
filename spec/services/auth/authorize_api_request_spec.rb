require 'rails_helper'

RSpec.describe Auth::AuthorizeApiRequest do
  let(:user) { create(:user) }
  let(:header) { { 'Authorization' => token_generator(user.id) } }

  subject(:request_obj) { described_class.new(header) }
  subject(:invalid_request_obj) { described_class.new({}) }

  describe '#call' do
    context 'when valid request' do
      it 'returns user object' do
        auth_user = request_obj.call
        expect(auth_user.result).to eq user
      end
    end

    context 'when invalid request' do
      context 'when missing token' do
        it 'raises a MissingToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(
              ExceptionHandler::MissingToken,
              'Authentication token is missing'
            )
        end
      end

      context 'when invalid token' do
        subject(:invalid_request_obj) do
          described_class.new('Authorization' => token_generator(5))
        end

        it 'raises an InvalidToken error' do
          expect { invalid_request_obj.call }
            .to raise_error(ExceptionHandler::InvalidToken)
        end
      end

      context 'when token is expired' do
        let(:header) { { 'Authorization' => expired_token_generator(user.id) } }
        subject(:request_obj) { described_class.new(header) }

        it 'raises ExceptionHandler::ExpiredSignature error' do
          expect { request_obj.call }
            .to raise_error(
              ExceptionHandler::ExpiredSignature,
              /Signature has expired/
            )
        end
      end
    end
  end
end
