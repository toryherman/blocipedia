FactoryGirl.define do
  factory :wiki do
    title { Faker::Lorem.sentence }
    body { Faker::Lorem.paragraph }
    private false
    user
    updated_by { user.id }
  end
end
