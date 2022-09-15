# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    order
    code { FFaker::String.random(length: 4..10) }
    sale { FFaker::Number.between(from: 0.0, to: 1.0) }
    active { true }
  end
end
