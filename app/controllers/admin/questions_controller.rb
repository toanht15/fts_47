class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_categories

  def index
    @search = @questions.search params[:q]
    @questions = @search.result.paginate page: params[:page]
  end

  def create
    if @question.save
      flash[:success] = t "question.success"
      redirect_to admin_questions_path
    else
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
      :category_id, answers_attributes: [:id, :content, :correct]
  end

  def load_categories
    @categories = Category.all
  end
end
