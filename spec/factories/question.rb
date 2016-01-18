require "faker"
FactoryGirl.define do
  factory :question, class: Question do
    content {Faker::Lorem.word}
    user {FactoryGirl.create :user}
    category {FactoryGirl.create :category}
    question_type [:single_choice, :multiple_choices, :text].sample
    status :waitting
    answers [FactoryGirl.build(:answer)]
  end
end
