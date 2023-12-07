class CartsController < ApplicationController
  before_action :set_cart
  def new
    @cart = current_user.cart || current_user.cart.build
  end

  def show
  end

  def update

  end

  private

  def set_cart
    @cart = current_user.cart
  end
end
