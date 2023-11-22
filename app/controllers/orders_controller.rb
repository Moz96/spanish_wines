class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]
  def index
    @orders = current_user.orders
  end

  def new
    @product = Product.find(params[:product_id])
    @order = @product.orders.new
  end

  def create
    @order = Order.new(params[:order])
    @order.user = current_user
    if @order.save
      flash[:success] = "Object successfully created"
      redirect_to @order
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  def order_params
    params.require(:order).permit(:product_id) # Include other necessary fields
  end
end
