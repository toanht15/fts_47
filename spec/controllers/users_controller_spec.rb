require "rails_helper"

RSpec.describe Admin::UsersController, type: :controller do
  let!(:admin) {FactoryGirl.create :admin}
  let!(:user) {FactoryGirl.create :user}

  before do
    sign_in admin
    allow(controller).to receive(:current_user).and_return admin
  end

  describe "GET #index" do
    it "responds successfully with an HTTP 200 status code" do
      get :index
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template("index")
    end
  end

  describe "DELETE destroy" do
    it "delete success" do
      delete :destroy, id: user.id
      expect(flash[:success]).to be_present
      expect(response).to redirect_to admin_users_url
    end
  end
end
