module Auth
  class AuthorizeApiRequest
    prepend SimpleCommand

    def initialize(headers = {})
      @headers = headers
    end

    def call
      user
    end

    private

    attr_reader :headers

    def user
      @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
      @user || errors.add(:token, 'Invalid token') && nil
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(valid_http_auth_header)
    end

    def valid_http_auth_header
      http_auth_header.present? ? http_auth_header.split(' ').last : nil
    end

    def http_auth_header
      headers['Authorization']
    end
  end
end
