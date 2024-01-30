class CheckoutController < ApplicationController
  def create
    product = Product.find(params[:id])

    # Create a product in Stripe
    stripe_product = Stripe::Product.create(name: product.name)

    # Create a price in Stripe and associate it with the product
    stripe_price = Stripe::Price.create(
      unit_amount: (product.price * 100).to_i,  # Convert price to cents
      currency: 'gbp',
      product: stripe_product.id
    )

    @session = Stripe::Checkout::Session.create({
      payment_method_types: ['card'],
      line_items: [{
        price: stripe_price.id,
        quantity: 1
      }],
      mode: 'payment',
      success_url: root_url,
      cancel_url: root_url,
    })

    respond_to do |format|
      format.js
    end
  end
end
