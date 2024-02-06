class CheckoutsController < ApplicationController
  def show
    @product = product
    @session = Stripe::Checkout::Session.create(
      line_items: [{
        price_data: {
          currency: "gbp",
          product_data: {
            name: product.name
          },
          unit_amount: product.price * 100
        },
        quantity: 1
      }],
      mode: "payment",
      ui_mode: "embedded",
      return_url: CGI.unescape(payment_url(session_id: '{CHECKOUT_SESSION_ID}'))
    )
    current_user.orders.create(stripe_checkout_id: @session.id)

    respond_to do |format|
      format.html
      format.js
    end
  end

  private

  def product
    @product ||= Product.find(params[:id])
  end
end
