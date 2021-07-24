class ApplicationController < ActionController::Base
  before_action :set_article_q
  # CSRF対策
  protect_from_forgery with: :exception

  # 記事検索用
  def search
    @results = @q.result
  end

  def set_article_q
    @q = Article.ransack(params[:q])
  end
end
