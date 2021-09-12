class QuestionsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

  def index
    # kaminariによるpage perメソッドを使用し、１０記事毎にページネイション
    @questions = Question.page(params[:page]).per(10).order('created_at DESC')
  end

  def show
    @question = Question.find(params[:id])
    @answer = Answer.new
    @answers = @question.answers.includes(:user)
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new(question_params)
    @question.user_id = current_user.id
    if @question.save
      flash[:notice] = "質問を作成しました"
      redirect_to questions_path
    else
      flash[:alert] = "質問の作成に失敗しました"
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
    unless @question.user_id == current_user.id
      redirect_to root_path
      flash[:alert] = "他の方の質問は編集できません"
    end
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      flash[:notice] = "質問を更新しました"
      redirect_to @question
    else
      flash[:alert] = "質問の更新に失敗しました"
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    flash[:alert] = "質問を削除しました"
    redirect_to @question
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
