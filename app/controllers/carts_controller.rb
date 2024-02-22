class CartsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart, only: [:show, :destroy]
  before_action :cleanup_cart, only: [:show]

  def show
    @cart_items = @cart.cart_items.includes(:product)
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

  def cleanup_cart
    @cart.cart_items.each do |cart_item|
      unless cart_item.product.present?
        cart_item.destroy
        flash[:notice] = "A product in your cart is no longer available and has been removed."
      end
    end
  end

end
