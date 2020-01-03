FactoryBot.define do
    factory :comment do
      text { Faker::Lorem.sentence }
      event_id { nil }
      user_id { nil }
    end
  end