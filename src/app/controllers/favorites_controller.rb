class FavoritesController < ApplicationController
  def create
    @article = Article.find(params[:article_id]) # views/favorites/create.js.erbへ送るため
    favorite = current_user.favorites.build(article_id: params[:article_id])
    favorite.save
  end

  def destroy
    @article = Article.find(params[:article_id]) # views/favorites/destroy.js.erbへ送るため
    favorite = Favorite.find_by(article_id: params[:article_id], user_id: current_user.id)
    favorite.destroy
  end
end
