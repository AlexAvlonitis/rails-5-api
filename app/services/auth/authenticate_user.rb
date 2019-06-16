module Auth
  class AuthenticateUser
    prepend SimpleCommand

    def initialize(params = {})
      @email = params[:email]
      @password = params[:password]
    end

    def call
      return unless authenticate_user

      generate_jwt
    end

    private

    attr_reader :email, :password

    def authenticate_user
      return user if user&.authenticate(password)

      errors.add :user_authentication, 'Invalid credentials'
      nil
    end

    def generate_jwt
      JsonWebToken.encode(user_id: user.id)
    end

    def user
      @user ||= User.find_by(email: email)
    end
  end
end
