# frozen_string_literal: true

module Books
  class BestsellersQuery
    def call
      Book.includes(orders: :order_items).where(required_orders).order('order_items.quantity DESC')
    end

    private

    def required_orders
      { orders: { order_state: %i[in_delivery complete delivered] } }
    end
  end
end
