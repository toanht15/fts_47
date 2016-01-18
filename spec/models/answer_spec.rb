require "rails_helper"

RSpec.describe Answer, type: :model do

  describe "association" do
    let(:answer){FactoryGirl.create :answer}
    it{expect(answer).to belong_to(:question)}
  end

  describe "should be valid" do
    let(:answer){FactoryGirl.build :answer}
    before {answer.content = ""}
    it {is_expected.to validate_presence_of(:content)}
  end
end
