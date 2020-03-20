Rails.application.routes.draw do
  mount ActionCable.server => "/cable"

  resources :rooms, only: [:create, :show], param: :token do
    resources :players, only: [:new, :create]
  end

  root to: 'pages#home'
end
