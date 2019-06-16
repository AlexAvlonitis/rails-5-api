module Api
  module V1
    class UserSerializer
      include FastJsonapi::ObjectSerializer

      attributes :email
    end
  end
end
