require "rails_helper"

RSpec.describe Question, type: :model do

  describe "association" do
    let(:question){FactoryGirl.create :question}
    it{expect(question).to have_many(:answers)}
    it{expect(question).to belong_to(:category)}
    it{expect(question).to belong_to(:user)}
  end

  describe "should be valid" do
    let(:question){FactoryGirl.build :question}
    before {question.content = ""}
    it {is_expected.to validate_presence_of(:content)}
  end
end
