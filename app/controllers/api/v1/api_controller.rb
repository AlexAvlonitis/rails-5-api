module Api
  module V1
    class ApiController < ApplicationController
      include ExceptionHandler

      before_action :authenticate_request

      private

      def authenticate_request
        valid_token
      rescue StandardError => e
        render json: { error: "Invalid token #{e.message}" }, status: :fobidden
      end

      def valid_token
        @valid_token ||=
          ::Auth::AuthorizeApiRequest.call(request.headers).result
      end
    end
  end
end
