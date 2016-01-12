class CategoryNotificationService
  def initialize category
    @user = User.all
    @category = category
  end

  def mail_to_user_when_create
    @user.each{|user| CategoryNotifier.send_create_category_email(user, @category).deliver_now}
  end
end
