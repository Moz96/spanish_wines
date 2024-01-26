class Admin::ProductsController < ApplicationController
  def index
    @products = Product.all
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params) # Instantiate the product from form params

    if @product.save
      flash[:success] = "New wine added"
      redirect_to admin_products_path
    else
      flash[:error] = "Wine not listed"
      render :new # Render the 'new' view to show the errors
    end
  end

  def edit
    set_product
  end

  def update
    set_product
    if @product.update(product_params)
      flash[:success] = "Wine updated"
      redirect_to admin_products_path
    else
      flash[:error] = "Update failed"
      render :edit
    end
  end

  def destroy
    @product = Product.find(params[:id])

    # Clear associated cart items
    @product.cart_items.clear

    if @product.destroy
      flash[:success] = "Product deleted successfully"
      redirect_to admin_products_path
    else
      flash[:error] = "Failed to delete product"
      redirect_back(fallback_location: admin_products_path)
    end
  end
  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :vintage, :quantity, :category)
  end
end
