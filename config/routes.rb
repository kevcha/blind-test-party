Rails.application.routes.draw do
  resources :rooms, only: [:create, :show], param: :token

  root to: 'pages#home'
end
