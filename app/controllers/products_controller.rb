class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :destroy]
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(params[:product])
    if @product.save
      flash[:success] = "Object successfully created"
      redirect_to @product
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  def show
    @reviews = @product.reviews
  end

  def edit
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


  def destroy
    if @product.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to products_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to products_url
    end
  end
  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :description, :price, :vintage, :quantity, :category)
  end
end
