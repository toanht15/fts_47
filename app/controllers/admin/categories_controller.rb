class Admin::CategoriesController < ApplicationController
  load_and_authorize_resource

  def new
    @categories = Category.new
  end

  def create
    @categories = Category.new category_params
    if @categories.save
      flash[:success] = t "category.created_successfull"
      redirect_to admin_categories_path
    else
      render :new
    end
  end

  def index
    @categories = Category.page params[:page]
  end

  def edit
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "category.updated_succesfull"
      redirect_to admin_categories_path
    else
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "category.deleted"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "error"
      redirect_to admin_categories_path
    end
  end

  private
  def category_params
    params.require(:category).permit :name
  end
end
