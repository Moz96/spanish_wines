class CartItemsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_cart
  before_action :set_cart_item

  def create
    product = Product.find(params[:product_id])
    quantity_to_add = params[:quantity].to_i
    available_quantity = product.quantity

    if quantity_to_add <= available_quantity
      @cart_item = @cart.cart_items.build(cart_item_params)
      if @cart_item.save
        redirect_to @cart, notice: 'Item added to cart.'
      else
        flash[:error] = 'Failed to add item to cart.'
        redirect_to products_path
      end
    else
      flash[:error] = "Cannot add more than #{available_quantity} items to cart."
      redirect_to products_path
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

  def cart_item_params
    params.require(:cart_item).permit(:product_id, :quantity)
  end
end
