class PaymentsController < ApplicationController
  def show
    @user = current_user
    @order = Order.includes(:products).find_by(
      user_id: @user.id,
      stripe_checkout_id: params[:session_id]
    )
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    if stripe_session.status == "complete"
      @order.paid!
    else
      @order.pending!
    end
    puts "@order: #{@order.inspect}" # Add this line for debugging
    puts "@order.products: #{@order.products.inspect}" # Add this line for debugging
  end
end
