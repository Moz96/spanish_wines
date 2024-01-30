class Admin::ProductsController < ApplicationController
  before_action :set_product, only: [ :edit, :update, :destroy]
  before_action :check_if_admin
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

  def update

  end
  def edit
  end

  def destroy
    @product.image.purge if @product.image.attached?
    @product.destroy
    flash[:success] = "Wine deleted"
    redirect_to admin_products_path
  end

  private

  def check_if_admin
    redirect_to root_path unless current_user.admin?
  end

  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.require(:product).permit(:name, :price, :description, :vintage, :quantity, :category, :image)
  end
end
