class UsersController < ApplicationController
  load_and_authorize_resource

  def create
    if request.patch? && params[:user]
      if @user.update user_params
        sign_in @user, bypass: true
        redirect_to root_url
      else
        @show_errors = true
      end
    end
  end

  private
  def user_params
    accessible = [:name, :email]
    accessible << [:password, :password_confirmation] unless params[:user][:password].blank?
    params.require(:user).permit accessible
  end
end
