class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy]

  def show
    # Retrieve the current user's cart items
    @cart_items = @cart.cart_items
  end

  def create
    @cart = current_user.build_cart(cart_params)

    if @cart.save
      redirect_to @cart, notice: 'Cart was successfully created.'
    else
      render :new
    end
  end

  def destroy
    @cart.destroy
    redirect_to root_path, notice: 'Cart was successfully destroyed.'
  end

  private

  def set_cart
    @cart = current_user.cart
  end

end
