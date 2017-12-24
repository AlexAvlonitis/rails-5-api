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
    rescue ActiveRecord::RecordNotFound => e
      raise ExceptionHandler::InvalidToken, "Invalid token #{e.message}"
    end

    def decoded_auth_token
      @decoded_auth_token ||= JsonWebToken.decode(valid_http_auth_header)
    end

    def valid_http_auth_header
      return http_auth_header.split(' ').last if http_auth_header.present?
      raise ExceptionHandler::MissingToken, 'Authentication token is missing'
    end

    def http_auth_header
      headers['Authorization']
    end
  end
end
