Rails.application.routes.draw do
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations", sessions: "users/sessions" }

  root 'home#index'

  # テストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_login'
  end

  resources :users, only: [:index, :show] do
    resource :relationships, only: [:create, :destroy]
    get :follows, on: :member
    get :followers, on: :member
  end

  resources :articles do
    resource :favorites, only: [:create, :destroy]
    resources :comments,  only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  # タグ検索結果表示ページ
  resources :tags, only: [:show]

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
