class Admin::UsersController < ApplicationController
  load_and_authorize_resource only: [:destroy, :index]

  def index
    @search = @users.search params[:q]
    @users = @search.result.paginate page: params[:page]
  end

  def destroy
    @user.destroy
    flash[:success] = t "delete"
    redirect_to admin_users_url
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
