require "faker"
FactoryGirl.define do
  factory :user do |f|
    f.name {Faker::Name.name}
    f.email {Faker::Internet.email}
    f.password {"pa0974340719"}
    f.password_confirmation {"pa0974340719"}
    factory :admin do
      f.admin {true}
    end
  end
end
