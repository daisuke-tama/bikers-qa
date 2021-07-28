class QuestionsController < ApplicationController
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
      redirect_to questions_path
    else
      render :new
    end
  end

  def edit
    @question = Question.find(params[:id])
  end

  def update
    @question = Question.find(params[:id])
    if @question.update(question_params)
      redirect_to @question
    else
      render :edit
    end
  end

  def destroy
    @question = Question.find(params[:id])
    @question.destroy
    redirect_to @question
  end

  private

  def question_params
    params.require(:question).permit(:title, :content)
  end
end
