class CategoryNotifier < ApplicationMailer
  def send_create_category_email user, category
    @user = user
    @category = category
    mail to: @user.email, subject: t("email.create_category")
  end
end
