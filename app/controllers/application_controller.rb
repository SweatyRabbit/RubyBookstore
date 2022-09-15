# frozen_string_literal: true

class ApplicationController < ActionController::Base
  helper_method :cart_items_count

  def cart_items_count
    Cart::CartItemsCountService.new(current_cart).call
  end

  def current_cart
    return Order.find(session[:cart_id]) if session[:cart_id]

    cart = Order.create
    session[:cart_id] = cart.id
    cart
  end
end
