# frozen_string_literal: true

FactoryBot.define do
  factory :card do
    number { FFaker::PhoneNumber.imei }
    name { FFaker::Name.first_name }
    expire_date { '10/22' }
    cvv { rand(100...999) }
  end
end
