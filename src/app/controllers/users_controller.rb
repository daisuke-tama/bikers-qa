class UsersController < ApplicationController
  # 未ログインユーザーをログイン画面へ転移させる
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    @articles = @user.articles
    @favorite_articles = @user.favorite_articles
  end
end
