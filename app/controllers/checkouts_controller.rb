class CheckoutsController < ApplicationController
  # def show
  #   @session = Stripe::Checkout::Session.create(
  #     line_items: [{
  #       price_data: {
  #         currency: "gbp",
  #         product_data: {
  #           name: product.name
  #         },
  #         unit_amount: product.price * 100
  #       },
  #       quantity: 1
  #     }],
  #     mode: "payment",
  #     ui_mode: "embedded",
  #     return_url: CGI.unescape(payment_url(session_id: '{CHECKOUT_SESSION_ID}'))
  #   )
  #   current_user.orders.create(stripe_checkout_id: @session.id)

  #   respond_to do |format|
  #     format.html
  #     format.js
  #   end
  # end
  def show
    @cart = current_user.cart
    line_items = @cart.cart_items.map do |cart_item|
      {
        price_data: {
          currency: "gbp",
          product_data: {
            name: cart_item.product.name
          },
          unit_amount: cart_item.product.price * 100
        },
        quantity: cart_item.quantity
      }
    end

    @session = Stripe::Checkout::Session.create(
      line_items: line_items,
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
