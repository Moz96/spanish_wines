import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="stripe-checkout"
export default class extends Controller {
  connect() {
     // This is your test publishable API key.
    const stripe = Stripe("pk_test_51OP1KvFrsywnBPS7Q9UbAdTv79lFLsXKMKQAd9wmsNIGBNFCqnJdaX0R6CPlrhqgu3htXx4smTWcOeOznfqqFWWe00L7sG1BZV");

    initialize();

    // Create a Checkout Session as soon as the page loads
    async function initialize() {
      const response = await fetch("/create-checkout-session", {
        method: "POST",
      });

      const { clientSecret } = await response.json();

      const checkout = await stripe.initEmbeddedCheckout({
        clientSecret,
      });

      // Mount Checkout
      checkout.mount('#checkout');
    }
  }
}
