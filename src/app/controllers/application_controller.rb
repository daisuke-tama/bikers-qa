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
  # 権限がないユーザーが管理用ページに移動しようとした際、トップページへリダイレクトする
  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.json { head :forbidden }
      format.html { redirect_to main_app.root_path, alert: "管理者権限がないのでアクセスできません" }
    end
  end
end
