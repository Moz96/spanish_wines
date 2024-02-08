class ProductsController < ApplicationController
  before_action :set_product, only: [:show]
  before_action :authenticate_user!, only: [:add_to_cart]
  def index
    @products = Product.all
  end


  def show
    @reviews = @product.reviews
  end


  def add_to_cart
    puts "Adding product to cart..."
    puts "Product ID: #{params[:id]}"
    product = Product.find(params[:id])

    if current_user.cart.nil?
      cart = current_user.create_cart
    else
      cart = current_user.cart
    end

    cart_item = cart.cart_items.find_by(product_id: product.id)

    if cart_item.present?
      cart_item.update(quantity: cart_item.quantity + 1)
    else
      puts "Creating new cart item..."
      cart_item = cart.cart_items.create(product: product, quantity: 1)
      if cart_item.errors.any?
        puts "Errors while saving cart item: #{cart_item.errors.full_messages.join(', ')}"
      else
        puts "Cart Item ID: #{cart_item.id}"
      end
    end
    puts "Cart ID: #{cart.id}"
    puts "Cart Item Quantity: #{cart_item.quantity}"

    redirect_to products_path, notice: 'Product added to cart successfully!'
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :vintage, :quantity, :category, :image)
  end
end
