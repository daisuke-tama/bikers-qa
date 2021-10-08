Rails.application.routes.draw do
  # 管理者用ページ
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  # 変更したdeviseのコントローラーの読み込み
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks', registrations: "users/registrations", sessions: "users/sessions" }
  # トップページ
  root 'home#index'
  # サイト内容説明ページ
  get '/about', to: 'home#about'
  # お問合せフォームページ
  get '/contact', to: 'home#contact'
  # テストログイン用
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_login'
  end
  # ユーザー関連 フォロー機能 フォロー一覧表示機能
  resources :users, only: :show do
    resource :relationships, only: [:create, :destroy]
    get :relationship_index, on: :member
  end
  # 記事関連 いいね機能とコメント機能 headerにある検索機能
  resources :articles do
    resource :favorites, only: [:create, :destroy] do
      # 同ページにfavorite-btnが２つあった場合、ajaxの設定上最初に読まれるもののみ動作する。２つ目以降のbtnはリロードしないと反映されないのでajaxを使わないものを用意
      post :not_ajax_create, on: :member
      delete :not_ajax_delete, on: :member
    end
    resources :comments, only: [:create, :destroy]
    collection do
      get 'search'
    end
  end
  # 質問関連
  resources :questions do
    resources :answers, only: [:create, :destroy]
  end
  # ダイレクトメッセージ関連
  resources :messages, only: [:create, :destroy]
  resources :rooms,    only: [:show, :create, :destroy]
  # タグ検索結果表示ページ
  resources :tags,     only: [:show]
  # 通知一覧表示ページ
  resources :notifications, only: :index do
    collection do
      delete 'destroy_all'
    end
  end
  # マイバイク機能
  resources :my_bikes
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
