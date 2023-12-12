class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  def index
    @products = Product.all
  end


  def show
    @reviews = @product.reviews
  end


  def add_to_cart
    product = Product.find(params[:id])
    if current_user.cart.nil?
      # If the user doesn't have a cart yet, create one
      cart = current_user.create_cart
    else
      cart = current_user.cart
    end

    # Check if the product is already in the cart
    cart_item = cart.cart_items.find_by(product_id: product.id)

    if cart_item.present?
      # If the product is already in the cart, increment its quantity
      cart_item.update(quantity: cart_item.quantity + 1)
    else
      # If the product is not in the cart, create a new cart item
      cart_item = cart.cart_items.create(product: product, quantity: 1)
    end

    redirect_to products_path, notice: 'Product added to cart successfully!'
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :vintage, :quantity, :category)
  end
end
