class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    # kaminariによるpage perメソッドを使用し、１０記事毎にページネイション
    @articles = @user.articles.page(params[:page]).per(10).order('created_at DESC')
    @favorite_articles = @user.favorite_articles.page(params[:page]).per(10).order('created_at DESC')
    @questions = @user.questions.page(params[:page]).per(10).order('created_at DESC')
    @answers = @user.answer_articles.page(params[:page]).per(10).order('created_at DESC')
    @dm_entries = current_user.entries.page(params[:page]).per(10).order('created_at DESC')
    # ================== DM機能 =============================
    @current_user_entry = Entry.where(user_id: current_user.id)
    @user_entry = Entry.where(user_id: @user.id)
    unless @user.id == current_user.id
      @current_user_entry.each do |cu|
        @user_entry.each do |u|
          if cu.room_id == u.room_id
            @working_room = true
            @room_number = cu.room_id
          end
        end
      end
      unless @working_room
        @room = Room.new
        @entry = Entry.new
      end
    end
    # ========================================================
  end

  def relationship_index
    user = User.find(params[:id])
    @followings = user.followings.page(params[:page]).per(10).order('created_at DESC')
    @followers = user.followers.page(params[:page]).per(10).order('created_at DESC')
  end
end
