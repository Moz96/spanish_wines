class Admin::ProductController < ApplicationController#
  before_action :authenticate_admin!

  def index
    @products = Product.all
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

  def destroy
    if @product.destroy
      flash[:success] = 'Object was successfully deleted.'
      redirect_to products_url
    else
      flash[:error] = 'Something went wrong'
      redirect_to products_url
    end
  end
end
