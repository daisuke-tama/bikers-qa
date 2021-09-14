class ArticlesController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    # kaminariによるpage perメソッドを使用し、１０記事毎にページネイション
    @articles = Article.includes([:user], [:tag_maps], [:tags], [:rich_text_content]).page(params[:page]).per(10).order('created_at DESC')
  end

  def show
    @article = Article.find(params[:id])
    @comment = Comment.new
    @comments = @article.comments.includes(:user)
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    tag_list = params[:article][:tag_names].split(",")
    @article.tags_save(tag_list)
    if @article.save
      flash[:notice] = "記事を作成しました"
      redirect_to @article
    else
      flash[:alert] = "記事の作成に失敗しました"
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
    unless @article.user_id == current_user.id
      redirect_to root_path
      flash[:alert] = "他の方の記事は編集できません"
    end
  end

  def update
    @article = Article.find(params[:id])
    tag_list = params[:article][:tag_names].split(",")
    @article.tags_save(tag_list)
    if @article.update(article_params)
      flash[:notice] = "記事を更新しました"
      redirect_to @article
    else
      flash[:alert] = "記事の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    flash[:alert] = "記事を削除しました"
    redirect_to @article
  end

  private

  def article_params
    params.require(:article).permit(:title, :content)
  end
end
