class UserMailer < ApplicationMailer
  def result_exam exam
    @exam = exam
    @user = exam.user

    mail to: user.email, subject: t("email.result_exam_subject")
  end
end
