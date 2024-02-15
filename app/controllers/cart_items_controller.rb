class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_cart_item

  def create
    @cart_item = @cart.cart_items.build(cart_item_params)
    if @cart_item.save
      redirect_to @cart, notice: 'Item added to cart.'
    else
      # Handle errors
    end
  end

  def update
    @cart_item = CartItem.find(params[:id])
    if params[:increment]
      @cart_item.quantity += 1
    elsif params[:decrement] && @cart_item.quantity > 1
      @cart_item.quantity -= 1
    end
    @cart_item.save
    redirect_to user_cart_path(current_user, @cart_item.cart)
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to user_cart_path(current_user, @cart_item.cart)
  end

  private

  def set_cart
    @cart = current_user.cart
  end

  def set_cart_item
    @cart_item = @cart.cart_items.find_by(id: params[:id])
  end
end
