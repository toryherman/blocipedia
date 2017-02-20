# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
25.times do
  User.create!(
    email: Faker::Internet.unique.email,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    password: "password",
    password_confirmation: "password",
    confirmed_at: Time.now,
    role: rand(0..2)
  )
end

me = User.create!(
  email: "tory.herman12@gmail.com",
  first_name: "Tory",
  last_name: "Herman",
  password: "password",
  password_confirmation: "password",
  confirmed_at: Time.now,
  role: "admin"
)

users = User.all

40.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: false,
    user: users.sample
  )
end

5.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: true,
    user: users.where(role: "admin").sample
  )
end

5.times do
  Wiki.create!(
    title: Faker::Lorem.sentence,
    body: Faker::Lorem.paragraph,
    private: true,
    user: users.where(role: "premium").sample
  )
end

puts "Seed finished"
puts "#{User.count} users created"
puts "#{Wiki.count} wikis created"
