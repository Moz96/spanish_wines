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

  end

  def destroy

  end

  private

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :vintage, :quantity, :category)
  end
end
