require "rails_helper"

RSpec.describe Admin::CategoriesController, type: :controller do
    let!(:category) {FactoryGirl.create :category}
    let!(:admin) {FactoryGirl.create :admin}

    before do
      sign_in admin
      allow(controller).to receive(:current_user).and_return admin
    end

    describe "can GET #new" do
      it "render new success" do
        get :new
        expect(assigns(:category)).to be_a_new Category
        expect(response).to render_template("categories/new")
        expect(response).to render_template("layouts/application")
      end
    end

    describe "can GET #edit" do
      it "render new success" do
        get :edit, id: category.id
        expect(assigns(:category)).to eq category
        expect(response).to render_template("categories/edit")
        expect(response).to render_template("layouts/application")
      end
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

    describe "POST create" do
      it "create success" do
        post :create, category: FactoryGirl.attributes_for(:category)
        expect(Category.count).to eq 2
        expect(flash[:success]).to be_present
        expect(response).to redirect_to admin_categories_path
      end
    end

    describe "PATCH update" do
      it "update success" do
        patch :update, id: category.id, category: FactoryGirl.attributes_for(:category)
        expect(flash[:success]).to be_present
        expect(response).to redirect_to admin_categories_path
      end
    end

    describe "DELETE destroy" do
      it "delete success" do
        delete :destroy, id: category.id
        expect(flash[:success]).to be_present
        expect(response).to redirect_to admin_categories_path
      end
    end
end
