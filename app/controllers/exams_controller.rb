class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @category = Category.all
    @exam = Exam.new
    @exams = @exams.page params[:page]
  end

  def show
    @time_remaining = @exam.remain_time
  end

  def create
    if @exam.save
      flash[:success] = t "exam.created"
    else
      flash[:danger] = t "error"
    end
    redirect_to :back
  end

  def update
    @exam.spent_time = @exam.time_spent
    if @exam.update_attributes exam_params
      flash[:success] = t "exam.saved"
    else
      flash[:danger] = t "error"
    end
    redirect_to exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :category_id, :user_id, :status, results_attributes: [
      :id, :question_id, content_answer: []]
  end
end
