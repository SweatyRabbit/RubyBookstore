# frozen_string_literal: true

FactoryBot.define do
  factory :order_item do
    book
    order
    quantity { FFaker::Random.rand(2...10) }
  end
end
