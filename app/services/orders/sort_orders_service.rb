# frozen_string_literal: true

module Orders
  class SortOrdersService < BaseService
    attr_reader :current_user, :orders

    DEFAULT_FILTER = :complete

    def initialize(params)
      super
      @order_state = params[:order_state]
      @user = params[:user]
    end

    def call
      @order_state ? find_orders : finished_orders
    end

    private

    def find_orders
      return unless valid_state?

      Order.where(order_state: @order_state, user_id: @user.id)
    end

    def finished_orders
      Order.where(user_id: @user.id).checkout_finished.order(created_at: :desc)
    end

    def valid_state?
      Order.order_states.except(:address, :delivery, :payment, :confirm).include?(@order_state)
    end
  end
end
