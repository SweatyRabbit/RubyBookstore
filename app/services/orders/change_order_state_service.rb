# frozen_string_literal: true

module Orders
  class ChangeOrderStateService < BaseService
    attr_reader :completed_order

    def initialize(params)
      super
      @order = params[:order]
      @state = params[:state]
      @user = params[:user]
    end

    def call
      return unless valid_state?

      @order.update(order_state: @state)

      complete_order if @state == Order.order_states.key(4)
    end

    private

    def complete_order
      OrderMailer.order_complete(@order, @user).deliver

      @user.orders << @order
      @completed_order = @order
    end

    def valid_state?
      Order.order_states.except(:delivered, :in_delivery, :canceled).include?(@state)
    end
  end
end
