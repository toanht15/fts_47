require "rails_helper"
require "rspec/active_model/mocks"

describe "admin/categories/new.html.erb" do
  subject {rendered}
  let!(:admin) {FactoryGirl.build :admin, admin: true}
  let(:category) {mock_model(Category).as_new_record.as_null_object}

  before do
    sign_in admin
    assign :category, category
    render
  end

  it do
    expect(controller.request.path_parameters[:controller]).to eq "admin/categories"
    expect(controller.request.path_parameters[:action]).to eq "new"
  end

  it do
    expect(rendered).to have_selector "form" do |form|
      form.is_epected.to have_selector "input", type: "text"
      form.is_epected.to have_selector "input", type: "submit"
    end
  end
end
