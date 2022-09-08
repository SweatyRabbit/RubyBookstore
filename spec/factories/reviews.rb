# frozen_string_literal: true

FactoryBot.define do
  factory :review do
    title { FFaker::Lorem.sentence }
    body { FFaker::Lorem.paragraph }
    book
    user
    book_rate { rand(0..5) }
    status { Review.statuses[:approved] }
  end
end
