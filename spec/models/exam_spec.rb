require "rails_helper"

RSpec.describe Exam, type: :model do
  let!(:exam){FactoryGirl.create :exam}

  describe "association" do
    it{expect(exam).to have_many(:results)}
    it{expect(exam).to have_many(:questions).through :results}
    it{expect(exam).to belong_to(:user)}
    it{expect(exam).to belong_to(:category)}
  end

  describe "create invalid" do
    it{expect(exam.errors).to be_empty}
  end
end
