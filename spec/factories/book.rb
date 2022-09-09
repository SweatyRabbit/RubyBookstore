FactoryBot.define do
  factory :book do
    title { FFaker::Lorem.word }
    price { FFaker.numerify('##.##') }
    description { FFaker::Book.description }
    publication_year { FFaker::Vehicle.year }
    height { FFaker.numerify('#.#') }
    width { FFaker.numerify('#.#') }
    depth { FFaker.numerify('#.#') }
    materials { FFaker::FreedomIpsum.word }
    category
    title_image { Rack::Test::UploadedFile.new('app/assets/images/default_book.png', 'default_book.png') }
    body_images do
      a = []
      3.times do
        a << Rack::Test::UploadedFile.new('app/assets/images/default_book.png', 'default_book.png')
      end
      a
    end

    trait :with_authors do
      authors { create_list(:author, rand(1..3)) }
    end
  end
end
