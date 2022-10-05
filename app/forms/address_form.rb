# frozen_string_literal: true

class AddressForm
  include ActiveModel::Model

  attr_accessor :id, :first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type, :user, :user_id,
                :created_at, :updated_at, :addressable_type, :addressable_id

  LENGTH = {
    fifty_length: 50,
    zip: 10,
    phone: 16
  }.freeze

  FORMAT = {
    only_letters: /\A[A-Za-z\s]+\z/,
    address: /\A[a-zA-Z0-9\s,\-]+\z/,
    zip: /\A[0-9\-]+\z/,
    phone: /\A\+[0-9]{1,3}\s?[0-9]{2}\s?[0-9]{3}\s?[0-9]{4}\z/
  }.freeze

  validates :first_name, :last_name, :address, :city, :zip, :country, :phone, :address_type, presence: true
  validates :first_name, :last_name, :address, :city, length: { maximum: LENGTH[:fifty_length] }
  validates :first_name, :last_name, :city, format: { with: FORMAT[:only_letters] }
  validates :phone, length: { maximum: LENGTH[:phone] }, format: { with: FORMAT[:phone] }
  validates :zip, length: { maximum: LENGTH[:zip] }, format: { with: FORMAT[:zip] }
  validates :address, format: { with: FORMAT[:address] }
  validate :country_from_the_above
  validate :country_code_of_the_selected_country

  def save(object)
    return false if invalid?

    case address_type
    when 'billing' then object.billing_address = Address.new(params)
    when 'shipping' then object.shipping_address = Address.new(params)
    end
  end

  def params
    {
      first_name: first_name,
      last_name: last_name,
      zip: zip,
      country: country,
      city: city,
      phone: phone,
      address_type: address_type,
      address: address
    }
  end

  private

  def country_from_the_above
    errors.add(:country, :invalid) unless ISO3166::Country.find_country_by_name(country)
  end

  def country_code_of_the_selected_country
    selected_country = ISO3166::Country.find_country_by_name(country)
    errors.add(:phone, :invalid) if selected_country.present? && phone.exclude?("+#{selected_country.country_code}")
  end
end
