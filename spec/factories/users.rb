FactoryGirl.define do
  factory :user do
    username RandomData.random_word
    first_name RandomData.random_word
    last_name RandomData.random_word
    sequence(:email) { |n| "user#{n}@factory.com" }
    password "password"
    password_confirmation "password"
    confirmed_at Time.now
  end
end
