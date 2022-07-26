FactoryBot.define do
  factory :book do
    title { FFaker::Lorem.word }
    price { FFaker::Number.decimal }
    description { FFaker::Lorem.paragraph }
    category

    trait :with_authors do
      authors { create_list(:author, rand(1..2)) }
    end
  end
end
