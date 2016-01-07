class Admin::ExamsController < ApplicationController
  load_resource

  def index
    @exams = @exams.page params[:page]
  end

  def show
  end

  def update
    if @exam.update_attributes exam_params
      flash[:success] = t "exam.saved"
    else
      flash[:danger] = t "error"
    end
    redirect_to admin_exams_path
  end

  private
  def exam_params
    params.require(:exam).permit :category_id, :user_id, :status, results_attributes: [
      :id, :question_id, :correct, content_answer: []]
  end
end
