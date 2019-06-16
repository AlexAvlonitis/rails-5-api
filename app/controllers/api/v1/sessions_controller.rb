module Api
  module V1
    class SessionsController < ApiController
      skip_before_action :authenticate_request, only: :create

      def create
        if authentication.success?
          render json: {
            access_token: authentication.result,
            message: 'Login Successful'
          }
        else
          render json: { error: authentication.errors }, status: :unauthorized
        end
      end

      private

      def authentication
        @authentication ||= ::Auth::AuthenticateUser.call(login_params)
      end

      def login_params
        params.permit(:email, :password)
      end
    end
  end
end
