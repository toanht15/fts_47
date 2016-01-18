require "faker"
FactoryGirl.define do
  factory :answer do
    content Faker::Lorem.characters(10)
    correct true
  end
end
