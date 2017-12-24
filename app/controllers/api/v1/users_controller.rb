module Api
  module V1
    class UsersController < ApiController
      skip_before_action :authenticate_request!, only: :create

      def index
        @users ||= User.all
        render json: @users, status: :ok
      end

      def create
        user = User.new(user_params)

        if user.save
          auth_token = ::Auth::AuthenticateUser.call(user_params)

          response = {
            message: 'User created successfully',
            auth_token: auth_token.result
          }
          render json: response, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.permit(:email, :password)
      end
    end
  end
end
