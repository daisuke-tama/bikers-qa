class CommentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = "コメントを投稿しました"
      redirect_to article_path(@comment.article)
    else
      @article = @comment.article
      @comments = @article.comments.includes(:user)
      flash[:alert] = "コメントの投稿に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    comment = Comment.find_by(id: params[:id], article_id: params[:article_id])
    comment.destroy
    redirect_to article_path(comment.article)
  end

  private

  def comment_params
    params.require(:comment).permit(:body).merge(user_id: current_user.id, article_id: params[:article_id])
  end
end
