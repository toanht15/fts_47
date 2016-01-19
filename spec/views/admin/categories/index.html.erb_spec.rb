require "rails_helper"

describe "admin/categories/index.html.erb" do
  let!(:user) {create :user}
  let!(:category) {create :category}
  let!(:categories) {Category.all.page(1)}
  before do
    sign_in user
    assign :categories, categories
    render
  end

  it do
    expect(controller.request.path_parameters[:controller]).to eq "admin/categories"
    expect(controller.request.path_parameters[:action]).to eq "index"
  end

  it do
    expect(rendered).to have_content category.name
  end
end
