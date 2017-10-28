Rails.application.routes.draw do
  mount_devise_token_auth_for 'User', at: 'auth'

  scope module: :v1,
        constraints: ApiConstraints.new(version: 1, default: true) do
  end
end
