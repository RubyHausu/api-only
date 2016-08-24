Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users, only: [:index, :create, :show, :update, :destroy]

  resources :sessions, only: [:create]

  scope path: '/user/:user_id' do
    resources :microposts, only: [:index]
  end
end
