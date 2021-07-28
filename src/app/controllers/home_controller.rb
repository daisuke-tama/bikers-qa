class HomeController < ApplicationController
  def index
    @favorite_ranking = User.find(Relationship.group(:follower_id).order('count(follower_id) desc').limit(10).pluck(:follower_id))
    @articles = Article.order(id: :desc).limit(10)
    @article_ranking = Article.find(Favorite.group(:article_id).order('count(article_id) desc').limit(10).pluck(:article_id))
    # TagモデルにTagMapモデルのtag_id（tag_id毎にグループ化＋多い順にソート＋取得数１０＋Tagモデルのidとするためにtag_idを数値で取得）を代入
    @tag_ranking = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
    @questions = Question.order(id: :desc).limit(10)
  end

  def about
  end
end
