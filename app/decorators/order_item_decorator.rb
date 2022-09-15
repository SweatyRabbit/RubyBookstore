# frozen_string_literal: true

class OrderItemDecorator < ApplicationDecorator
  delegate_all
  decorates_association :book

  def subtotal
    book.price * quantity
  end
end
