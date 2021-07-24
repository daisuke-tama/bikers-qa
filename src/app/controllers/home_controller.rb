class HomeController < ApplicationController
  def index
    @articles = Article.order(id: :desc).limit(10)
    # TagモデルにTagMapモデルのtag_id（tag_id毎にグループ化＋多い順にソート＋取得数１０＋Tagモデルのidとするためにtag_idを数値で取得）を代入
    @tag_ranking = Tag.find(TagMap.group(:tag_id).order('count(tag_id) desc').limit(10).pluck(:tag_id))
  end
end
