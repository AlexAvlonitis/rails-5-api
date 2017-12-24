Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    scope module: :v1, constraints: ApiConstraints.new(version: 1,
                                                       default: true) do
      post 'user/sign_up', to: 'users#create'
      post 'user/sign_in', to: 'sessions#create'
    end
  end
end
