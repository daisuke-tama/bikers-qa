class ArticlesController < ApplicationController
  def index
    @articles = Article.all.order(id: :desc)
  end

  def show
    @article = Article.find(params[:id])
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
      redirect_to articles_path
    else
      render :new
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    tag_list = params[:article][:tag_names].split(",")
    @article.tags_save(tag_list)
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to @article
  end

  private

  def article_params
    params.require(:article).permit(:title, :body)
  end
end
