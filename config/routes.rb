Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  resources :rooms, only: [:create, :show], param: :token do
    member do
      get '/join', to: 'rooms#join'
    end
  end

  root to: 'pages#home'
end
