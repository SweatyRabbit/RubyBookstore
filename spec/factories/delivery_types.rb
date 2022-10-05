# frozen_string_literal: true

FactoryBot.define do
  factory :delivery_type do
    name { FFaker::FreedomIpsum.word }
    min_days { FFaker::Random.rand(1...6) }
    max_days { FFaker::Random.rand(7...15) }
    price { FFaker.numerify('##.##') }
  end
end
