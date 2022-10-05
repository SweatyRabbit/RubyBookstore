# frozen_string_literal: true

module Cart
  class UpdateOrderItemService < BaseService
    def initialize(params)
      super
      @order_item_params = params[:order_item_params]
      @order = params[:order]
    end

    def call
      @order_item_params[:destroy_id] ? delete_item : update_item
    end

    private

    def delete_item
      @order.order_items.find_by(id: @order_item_params[:destroy_id]).destroy
      assign_success_message('cart.item_deleted')
    end

    def update_item
      @order_item_params[:quantity] = order_item.quantity + @order_item_params[:quantity].to_i if order_item.persisted?
      order_item.update(@order_item_params)
      order_item.valid? ? assign_success_message('cart.book_added') : add_errors
    end

    def order_item
      @order_item ||= @order.order_items.find_or_initialize_by(book_id: @order_item_params[:book_id])
    end

    def add_errors
      @errors << order_item.errors.full_messages
    end
  end
end
