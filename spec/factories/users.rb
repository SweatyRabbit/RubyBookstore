FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { "A#{FFaker::Internet.password}" }
    confirmed_at { Time.zone.now }
  end
end
