require "rails_helper"

RSpec.describe QuestionsController, type: :controller do
  let!(:user) {create :user}
  let!(:category) {create :category}
  let!(:question) {create :question, user: user, category: category}

  before do
    sign_in user
    allow(controller).to receive(:current_user).and_return user
  end

  describe "GET #index" do
    it "render index success" do
      get :index , user_id: user.id
      expect(assigns(:questions)).to eq user.questions.order("content")
      expect(response).to render_template("questions/index")
      expect(response).to render_template("layouts/application")
    end
  end

  describe "GET #new" do
    it "render new success" do
      get :new , user_id: user.id
      expect(assigns(:question)).to be_a_new Question
      expect(response).to render_template("questions/new")
      expect(response).to render_template("layouts/application")
    end
  end

  describe "POST #create" do
    it "success" do
      post :create, user_id: user.id, question: attributes_for(:question)
      expect(assigns(:question).save).to be_truthy
      expect(response.redirect?).to be_truthy
      expect(flash[:success]).to be_present
    end
  end

  describe "GET #edit" do
    it "render edit success" do
      get :edit , user_id: user.id, id: question.id
      expect(assigns(:question)).to eq question
      expect(response).to render_template("questions/edit")
      expect(response).to render_template("layouts/application")
    end
  end

  describe "PATCH #update" do
    it "success" do
      patch :update , user_id: user.id, id: question.id,
        question: attributes_for(:question)
      expect(assigns(:question).save).to be_truthy
      expect(response.redirect?).to be_truthy
      expect(flash[:success]).to be_present
    end
  end

  describe "DELETE #destroy" do
    it "success" do
      delete :destroy , user_id: user.id, id: question.id,
        question: attributes_for(:question)
      expect(assigns(:question).save).to be_truthy
      expect(response.redirect?).to be_truthy
      expect(flash[:success]).to be_present
    end
  end
end
