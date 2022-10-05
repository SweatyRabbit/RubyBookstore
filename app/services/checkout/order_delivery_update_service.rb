# frozen_string_literal: true

module Checkout
  class OrderDeliveryUpdateService < BaseService
    def initialize(params)
      super
      @delivery_params = params[:order_params]
      @order = params[:order]
    end

    def call
      delivery_type = DeliveryType.find_by(id: @delivery_params[:delivery_id])
      return unless delivery_type

      @order.delivery_type = delivery_type
      @order.payment_step!
    end
  end
end
