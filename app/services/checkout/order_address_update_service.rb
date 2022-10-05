# frozen_string_literal: true

module Checkout
  class OrderAddressUpdateService < BaseService
    def initialize(params)
      super
      @address_params = params[:order_params]
      @order = params[:order]
    end

    def call
      update_address_type(@address_params[:shipping_address]) unless @address_params[:only_billing]
      update_address_type(@address_params[:billing_address])
      @order.delivery_step! if success?
    end

    private

    def update_address_type(address_type)
      address_form = AddressForm.new(address_type)
      @errors << address_form.errors.full_messages unless address_form.save(@order)
    end
  end
end
