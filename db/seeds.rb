require 'faker'
# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
2.times do
    User.create(
        name: Faker::JapaneseMedia::DragonBall.character,
        email: Faker::Internet.email,
        password: "123",
        password_confirmation: "123"
    )
end

3.times do
    Event.create(
        name: Faker::DcComics.title,
        description: Faker::Lorem.sentence,
        latitude: Faker::Number.decimal(l_digits: 2, r_digits: 2), 
        longitude: Faker::Number.decimal(l_digits: 2, r_digits: 2)
    ) 
end