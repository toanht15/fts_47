require "rails_helper"
require "cancan/matchers"

RSpec.describe User, type: :model do

  let!(:user){FactoryGirl.create :user}
  let!(:user1){FactoryGirl.create :user}

  it{is_expected.to respond_to :name}
  it{is_expected.to respond_to :email}
  context "user is valid account" do
    it "name is blank" do
      user.email = ""
      expect(user).to_not be_valid
    end

    it "name has lenght > 100" do
      user.name = "a"*101
      expect(user).to_not be_valid
    end

    it "email is dulicates" do
      expect{
        user1.email = user.email
        user1.save
      }.to change{User.count}.by 0
    end

    it "password is blank" do
      user.password = ""
      expect(user).to_not be_valid
    end

    it "password lenght < 8" do
      user.password = "1234567"
      expect(user).to_not be_valid
    end

    it "password_confirmation is blank" do
      user.password_confirmation = ""
      expect(user).to_not be_valid
    end
  end

  describe "admin abilities" do
    subject(:ability){Ability.new admin}

    context "user is an admin" do
      let(:admin){FactoryGirl.create(:user)}

      it{should be_able_to(:manage, Category)}
      it{should be_able_to(:manage, User)}
      it{should be_able_to(:manage, Question)}
      it{should be_able_to(:manage, Exam)}
    end
  end
end
