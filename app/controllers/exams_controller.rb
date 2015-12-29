class ExamsController < ApplicationController
  load_and_authorize_resource

  def index
    @exam = Exam.new
    @category = Category.all
  end

  def create
    if @exam.save
      flash[:success] = t "exam.created"
    else
      flash[:danger] = t "error"
    end
    redirect_to :back
  end

  private
  def exam_params
    params.require(:exam).permit :category_id, :user_id, :status
  end
end
