module Auth
  class AuthenticateUser
    prepend SimpleCommand

    def initialize(params = {})
      @email = params[:email]
      @password = params[:password]
    end

    def call
      JsonWebToken.encode(user_id: user.id) if user
    end

    private

    attr_reader :email, :password

    def user
      user = User.find_by(email: email)
      if user && user.authenticate(password)
        user
      else
        errors.add :user_authentication, 'Invalid credentials'
        nil
      end
    end
  end
end
