class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def new
    @categories = Category.new
  end

  def create
    @categories = Category.new category_params
    if @categories.save
      flash[:success] = t "category.created_successfull"
      redirect_to request.referrer
    else
      render :new
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
