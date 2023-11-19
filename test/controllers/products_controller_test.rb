require "test_helper"

class ProductsControllerTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "should create product" do
    assert_difference('Product.count') do
      post products_url, params: { product: { name: 'Sample Product', price: 10.99 } }
    end
    assert_redirected_to product_url(Product.last)
  end
end
