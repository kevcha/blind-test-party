Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  resources :rooms, only: [:create, :show], param: :token do
    member do
      post '/join', to: 'rooms#join'
      post '/', to: 'rooms#show'
    end
  end

  root to: 'pages#home'
end
