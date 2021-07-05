class UsersController < ApplicationController
  # 未ログインユーザーをログイン画面へ転移させる
  before_action :authenticate_user!
  
  def index
  end

  def show
  end
end
