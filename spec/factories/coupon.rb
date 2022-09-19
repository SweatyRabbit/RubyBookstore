# frozen_string_literal: true

FactoryBot.define do
  factory :coupon do
    order
    code { FFaker::Code.npi }
    sale { FFaker::Random.rand(0.0...1.0) }
    active { true }
  end
end
