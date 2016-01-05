class Admin::ImportsController < ApplicationController
  authorize_resource
  def create
    Import.import params[:file]
    flash[:success] = t "import_suscess"
    redirect_to admin_categories_url
  end
end
