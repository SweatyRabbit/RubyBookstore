# frozen_string_literal: true

class Order < ApplicationRecord
  include AASM

  belongs_to :user, optional: true

  has_many :order_items, dependent: :destroy
  has_many :books, through: :order_items

  has_one :coupon, dependent: :destroy

  has_one :order_delivery_type, dependent: :destroy
  has_one :delivery_type, through: :order_delivery_type
  has_one :card, dependent: :destroy

  enum order_state: { address: 0, delivery: 1, payment: 2, confirm: 3, complete: 4,
                      in_delivery: 5, delivered: 6, canceled: 7 }

  has_one :billing_address, -> { where(address_type: :billing) },
          inverse_of: :addressable, as: :addressable, class_name: 'Address', dependent: :destroy
  has_one :shipping_address, -> { where(address_type: :shipping) },
          inverse_of: :addressable, as: :addressable, class_name: 'Address', dependent: :destroy

  scope :in_progress, -> { where(order_state: %i[address delivery payment confirm complete in_delivery]) }
  scope :in_queue, -> { where(order_state: :complete) }
  scope :in_delivery, -> { where(order_state: :in_delivery) }
  scope :delivered, -> { where(order_state: :delivered) }
  scope :canceled, -> { where(order_state: :canceled) }
  scope :checkout_finished, -> { where(order_state: %i[complete in_delivery delivery canceled]) }

  aasm column: :order_state, enum: true do
    state :address, initial: true
    state :delivery, :payment, :confirm, :complete, :canceled, :delivered, :in_delivery

    event(:delivery_step) { transitions from: :address, to: :delivery }
    event(:payment_step) { transitions from: :delivery, to: :payment }
    event(:confirm_step) { transitions from: :payment, to: :confirm }
    event(:complete_step) { transitions from: :confirm, to: :complete }
    event(:in_delivery_step) { transitions from: :complete, to: :in_delivery }
    event(:delivered_step) { transitions from: :in_delivery, to: :delivered }
    event(:canceled_step) { transitions from: %i[complete in_delivery delivered], to: :canceled }
  end
end
