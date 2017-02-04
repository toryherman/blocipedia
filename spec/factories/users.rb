FactoryGirl.define do
  factory :user do
    first_name RandomData.random_word
    last_name RandomData.random_word
    sequence(:email) { |n| "user#{n}@factory.com" }
    password pw
    password_confirmation pw
  end
end
