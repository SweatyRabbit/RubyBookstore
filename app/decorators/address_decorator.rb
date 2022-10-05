# frozen_string_literal: true

class AddressDecorator < ApplicationDecorator
  delegate_all
  delegate :address, to: :object

  def full_name
    "#{first_name} #{last_name}"
  end
end
