require "rails_helper"

describe "exams/index.html.erb" do
  subject {rendered}
  let(:user) {create :user}
  let(:category) {create :category}
  let(:exam) {create :exam}

  before do
    sign_in user
    assign :exam, exam
    assign :exams, exam
    assign :categories, category
    render
  end

  it do
    is_expected.to have_selector "form", method: "post", action: exam_path do |form|
      form.is_expected.to have_selector "input", name: "user_id"
      form.is_expected.to have_selector "input", name: "status"
      form.is_expected.to have_selector "select", name: "category_id"
      form.is_expected.to have_selector "input", type: "submit"
    end
  end

  it do
    is_expected.to have_content exam.created_at
    is_expected.to have_content exam.category.name
    is_expected.to have_content exam.status
    is_expected.to have_content exam.spent_time
    is_expected.to have_content exam.mark
  end
end
