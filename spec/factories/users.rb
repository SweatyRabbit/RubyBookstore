FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    password { FFaker::Internet.password }
    created_at { FFaker::Time.zone.now }
  end
end
