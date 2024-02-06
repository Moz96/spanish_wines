class PaymentsController < ApplicationController
  def show
    puts params.inspect
    @user = current_user
    @order = Order.find_by(
      user_id: @user.id,
      stripe_checkout_id: params[:session_id]
    )
    stripe_session = Stripe::Checkout::Session.retrieve(params[:session_id])
    if stripe_session.status == "complete"
      @order.paid!
    else
      @order.pending!
    end
  end
end
