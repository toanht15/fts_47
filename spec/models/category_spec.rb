require "rails_helper"

RSpec.describe Category, type: :model do

  let!(:category){FactoryGirl.create :category}

  it{is_expected.to respond_to :name}

  context "category is valid account" do
    it "name is blank" do
      category.name = ""
      expect(category).to_not be_valid
    end

    it "name has length > 50" do
      category.name = "a"*101
      expect(category).to_not be_valid
    end
  end
end
