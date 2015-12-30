class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_categories

  def index
    @search = @questions.search params[:q]
    check = params[:check].nil? ? Settings.filter.all : params[:check]
    @questions = @search.result.send(check).page params[:page]
  end

  def create
    @question.user_id = current_user.id
    @question.status = Question.statuses[:accepted]
    if @question.save
      flash[:success] = t "question.success"
      redirect_to admin_questions_path
    else
      flash[:error] = t "question.error.create_fails"
      render :new
    end
  end

  def edit
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "question.updated_succesfull"
      redirect_to admin_questions_path
    else
      flash[:error] = t "question.error.update_fails"
      render :edit
    end
  end

  def destroy
    @question.destroy
    flash[:success] = t "question.delete_succesfull"
    redirect_to admin_questions_path
  end

  private
  def question_params
    params.require(:question).permit :content, :question_type,
      :category_id, :status, answers_attributes: [:id, :content, :correct]
  end

  def load_categories
    @categories = Category.all
  end
end
