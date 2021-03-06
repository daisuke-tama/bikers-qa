class FavoritesController < ApplicationController
  before_action :authenticate_user!

  def create
    @article = Article.find(params[:article_id]) # views/favorites/create.js.erbへ送るため
    favorite = current_user.favorites.build(article_id: params[:article_id])
    favorite.save
    @article.create_notification_favorite!(current_user) # 通知作成用
  end

  def destroy
    @article = Article.find(params[:article_id]) # views/favorites/destroy.js.erbへ送るため
    favorite = Favorite.find_by(article_id: params[:article_id], user_id: current_user.id)
    favorite.destroy
  end

  def not_ajax_create
    favorite = current_user.favorites.build(article_id: params[:article_id])
    favorite.save
    redirect_to request.referer
  end

  def not_ajax_delete
    favorite = Favorite.find_by(article_id: params[:article_id], user_id: current_user.id)
    favorite.destroy
    redirect_to request.referer
  end
end
