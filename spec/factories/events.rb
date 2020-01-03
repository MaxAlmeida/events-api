FactoryBot.define do
    factory :event do
        name { Faker::DcComics.title }
        description { Faker::Lorem.sentence }
        latitude {Faker::Number.decimal(l_digits: 2, r_digits: 2) }
        longitude {Faker::Number.decimal(l_digits: 2, r_digits: 2)}
    end
end