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
          render json: { message: 'User created successfully'}, status: :created
        else
          render json: user.errors, status: :unprocessable_entity
        end
      end

      private

      def user_params
        params.require(:user).permit(
          :username,
          :email,
          :password
        )
      end
    end
  end
end
