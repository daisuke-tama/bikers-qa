class AnswersController < ApplicationController
  before_action :authenticate_user!

  def create
    @answer = Answer.new(answer_params)
    if @answer.save
      redirect_to question_path(@answer.question)
    else
      @question = @answer.question
      @answers = @question.answers.includes(:user)
      flash[:alert] = "コメントの投稿に失敗しました"
      redirect_to request.referer
    end
  end

  def destroy
    answer = Answer.find_by(id: params[:id], question_id: params[:question_id])
    answer.destroy
    redirect_to question_path(answer.question)
  end

  private

  def answer_params
    params.require(:answer).permit(:body).merge(user_id: current_user.id, question_id: params[:question_id])
  end
end
