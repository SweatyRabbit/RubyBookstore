# frozen_string_literal: true

class OrderDecorator < ApplicationDecorator
  delegate_all
  decorates_associations :order_items, :addresses, :card

  def ordered_order_items
    order_items.includes(:book).order(:created_at)
  end

  def subtotal
    order_items.sum(&:subtotal)
  end

  def discount
    coupon&.sale || 0.0
  end

  def total_discount
    subtotal * discount
  end

  def total_price
    total = subtotal * (1 - discount)
    total.negative? ? 0.0 : total
  end

  def delivery_price
    delivery_type&.price || 0.0
  end

  def order_total
    total_price + delivery_price
  end

  def address_credentials_full_name(address_type)
    order_address(address_type).decorate.full_name
  end

  def order_address_address(address_type)
    order_address(address_type).address
  end

  def order_address_country(address_type)
    order_address(address_type).country
  end

  def address_city_with_zip(address_type)
    "#{order_address(address_type).city} #{order_address(address_type).zip}"
  end

  def address_phone(address_type)
    order_address(address_type).phone
  end

  def order_address(address_type)
    address_type == 'billing' ? billing_address : shipping_address
  end

  def state_done?(order_state)
    order_state_before_type_cast > Order.order_states[order_state]
  end

  def last_state?(index)
    order_checkout_states.count - 1 == index
  end

  def order_checkout_states
    %i[address delivery payment confirm complete]
  end

  def passed_state?(order_state)
    state_done?(order_state) || self.order_state == order_state
  end

  def humanized_state
    order_state.humanize
  end
end
