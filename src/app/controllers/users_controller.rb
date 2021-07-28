class UsersController < ApplicationController
  # 未ログインユーザーをログイン画面へ転移させる
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find(params[:id])
    # kaminariによるpage perメソッドを使用し、１０記事毎にページネイション
    @articles = @user.articles.page(params[:page]).per(10).order('created_at DESC')
    @favorite_articles = @user.favorite_articles.page(params[:page]).per(10).order('created_at DESC')
    @questions = @user.questions.page(params[:page]).per(10).order('created_at DESC')
    @answers = @user.answer_articles.page(params[:page]).per(10).order('created_at DESC')
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
