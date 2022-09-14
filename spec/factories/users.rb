FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { "A111#{FFaker::Internet.password}" }
    confirmed_at { Time.zone.now }
  end
end
