# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    first_name { FFaker::Name.first_name }
    last_name { FFaker::Name.last_name }
    address { FFaker::Address.street_address }
    city { FFaker::Address.city }
    zip { FFaker::Address.building_number }
    country { ISO3166::Country.all.sample.name }
    phone { "+#{ISO3166::Country.find_country_by_name(country).country_code}#{FFaker::Number.number(digits: 9)}" }
    address_type { Address.address_types.keys.sample }
  end
end
