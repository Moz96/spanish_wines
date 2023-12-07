class OrdersController < ApplicationController
  before_action :authenticate_user!
  def index
    @orders = current_user.orders
  end

  def create
    @product = Product.find(params[:product_id])
    @order = @product.orders.new(order_params)
    @order.user = current_user

    if @order.save
      flash[:success] = "Order successfully created"
      redirect_to user_order_path(current_user, @order)
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end
  def order_params
    params.require(:order).permit(:product_id, :user_id)
  end
end
