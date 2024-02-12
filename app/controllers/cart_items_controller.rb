class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart

  def create
    @cart_item = @cart.cart_items.build(cart_item_params)
    if @cart_item.save
      redirect_to @cart, notice: 'Item added to cart.'
    else
      # Handle errors
    end
  end

  def update
    @cart_item = @cart.cart_items.find(params[:id])
    new_quantity = params[:quantity].to_i

    if new_quantity <= 0
      @cart_item.destroy
      redirect_to @cart, notice: 'Item removed from cart successfully!'
    else
      @cart_item.update(quantity: new_quantity)
      redirect_to @cart, notice: 'Cart item quantity updated.'
    end
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to user_cart_path(current_user, @cart_item.cart), notice: 'Item removed from cart successfully!'
  end

  private

  def set_cart
    @cart = current_user.cart
  end

end
