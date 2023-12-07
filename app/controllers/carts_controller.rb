class CartsController < ApplicationController
  def def new
    @cart = current_user.cart || current_user.cart.build
  end

end
