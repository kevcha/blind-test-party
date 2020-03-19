Rails.application.routes.draw do
  resources :rooms, only: [:create, :show], param: :token do
    member do
      get '/join', to: 'rooms#join'
    end
  end

  root to: 'pages#home'
end
