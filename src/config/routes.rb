Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations", sessions: "users/sessions" }

  root 'home#index'

  # テストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_login'
  end

  resources :users, only: [:index, :show]

  resources :articles
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
