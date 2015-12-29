class Admin::QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_categories

  def index
    @questions = @questions.paginate page: params[:page]
  end

  def create
    if @question.save
      flash[:success] = t "question.success"
      redirect_to admin_questions_path
    else
      render :new
    end
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
