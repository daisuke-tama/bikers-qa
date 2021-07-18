class UsersController < ApplicationController
  # 未ログインユーザーをログイン画面へ転移させる
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles.order(id: :desc)
    @favorite_articles = @user.favorite_articles.order(id: :desc)
  end

  def follows
    user = User.find(params[:id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:id])
    @users = user.followers
  end
end
