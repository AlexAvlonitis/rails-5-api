module Api
  module V1
    class SessionsController < ApiController
      skip_before_action :authenticate_request!, only: :create

      def create
        authenticate(login_params)
      end

      private

      def login_params
        params.permit(:email, :password)
      end

      def authenticate(login_params)
        command = ::Auth::AuthenticateUser.call(login_params)

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
