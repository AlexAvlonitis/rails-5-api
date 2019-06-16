module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_request, only: :create

      def index
        @users ||= User.all

        render json: @users, status: :ok
      end

      def create
        user = User.new(user_params)

        if user.save
          render json: success_response, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end

      def success_response
        {
          message: 'User created successfully',
          access_token: access_token.result
        }
      end

      def access_token
        @access_token ||= ::Auth::AuthenticateUser.call(user_params)
      end
    end
  end
end
