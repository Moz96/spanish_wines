class ProductsController < ApplicationController
  before_action :set_product, only: [:show, :edit, :destroy]
  def index
    @product = Product.all
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
  end

  def edit
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
    params.require(:product).permit(:name, :description, :price, :vintage, :quantity, :category_id)
  end
end
