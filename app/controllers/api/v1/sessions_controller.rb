module Api
  module V1
    class SessionsController < ApiController
      skip_before_action :authenticate_request!, only: :create

      def create
        authenticate(login_params)
      end

      private

      def login_params
        params.require(:user).permit(
          :email,
          :password
        )
      end

      def authenticate(login_params)
        email = login_params[:email]
        password = login_params[:password]

        command = ::Auth::AuthenticateUser.call(email, password)
        if command.success?
          render json: {
            access_token: command.result,
            message: 'Login Successful'
          }
        else
          render json: { error: command.errors }, status: :unauthorized
        end
      end
    end
  end
end
