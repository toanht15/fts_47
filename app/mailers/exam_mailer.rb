class ExamMailer < ApplicationMailer
  def notify_delay exam
    @exam = exam
    @user = exam.user
    mail to: @user.email, subject: t("email.exam_delay")
  end

  def notify_when_end_of_month exam
    @exam = exam
    @user = exam.user
    mail to: @user.email, subject: t("email.exam_result")
  end
end
