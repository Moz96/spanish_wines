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

    cart_items_valid = true
    current_user.cart.cart_items.each do |cart_item|
      product = cart_item.product
      if product.quantity < cart_item.quantity
        cart_items_valid = false
        flash[:error] = "Not enough stock available for #{product.name}"
        break
      end
    end

    if cart_items_valid
      current_user.cart.cart_items.each do |cart_item|
        product = cart_item.product
        product.update(quantity: product.quantity - cart_item.quantity)
      end
      current_user.cart.cart_items.destroy_all
      flash[:success] = "Checkout successful!"
    else
      flash[:error] ||= "Checkout failed due to insufficient stock"
    end

    puts "Cart items valid: #{cart_items_valid}"
    puts "Flash message: #{flash[:error]}"

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
