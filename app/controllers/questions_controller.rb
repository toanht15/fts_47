class QuestionsController < ApplicationController
  load_and_authorize_resource
  before_action :load_categories, except: [:index, :destroy]

  def index
    @questions = current_user.questions.paginate page: params[:page]
  end

  def create
    @question.user_id = current_user.id
    if @question.save
      flash[:success] = t "question.success"
      redirect_to questions_path
    else
      render :new
    end
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
