Rails.application.routes.draw do
  get 'version/create'

  get 'version/destroy'

  resources :documents do
    resources :versions do
      get 'update_status', as: :status
    end
  end

  get 'pages/home'

  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  root 'pages#index'
end
