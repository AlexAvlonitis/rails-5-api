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
      @user ||= User.find(access_token[:user_id])
    rescue ActiveRecord::RecordNotFound => e
      raise ExceptionHandler::InvalidToken, 'Invalid Token'
    end

    def access_token
      @access_token ||= JsonWebToken.decode(token_from_header)
    end

    def token_from_header
      authorization_header.split(' ').last
    rescue StandardError
      raise ExceptionHandler::MissingToken, 'Authentication token is missing'
    end

    def authorization_header
      headers['Authorization']
    end
  end
end
