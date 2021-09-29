class HomeController < ApplicationController
  def index
    # ============== １０記事表示関連 =================
    @articles = Article.includes([:user], [:tag_maps], [:tags], [:rich_text_content]).order(id: :desc).limit(10)
    @questions = Question.includes([:user], [:rich_text_content]).order(id: :desc).limit(10)
    # ===============================================
    # =============== ランキング関連 =====================================
    @article_ranking = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(10).pluck(:article_id))
    @tag_ranking = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    @follower_ranking = User.find(Relationship.group(:follower_id).order('count(follower_id) desc').limit(10).pluck(:follower_id))
    # ==================================================================
  end

  def about
  end

  def contact
  end
end
