# frozen_string_literal: true

module Cart
  class UpdateCartService < BaseService
    def initialize(params)
      super
      @order_params = params[:order_params]
      @order = params[:order]
    end

    def call
      service = if @order_params.key?(:order_item)
                  Cart::UpdateOrderItemService.call(order_item_params: @order_params[:order_item], order: @order)
                else
                  Cart::AddCouponService.call(coupon: @order_params[:coupon], order: @order)
                end
      return unless service

      @success_message = service.success_message
      @errors = service.errors
    end
  end
end
