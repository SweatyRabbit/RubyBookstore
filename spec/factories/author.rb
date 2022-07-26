FactoryBot.define do
  factory :author do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }

    trait :with_books do
      books { create_list(:book, 2) }
    end
  end
end
