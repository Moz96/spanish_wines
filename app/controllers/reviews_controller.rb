class ReviewsController < ApplicationController
  before_action :set_product, only: [:new, :create]

  def index
    @reviews = Review.all
  end

  def new
    @review = @product.reviews.new
  end

  def create
    @review = @product.reviews.build(review_params)
    @review.user = User.first
    if @review.save
      flash[:success] = "Object successfully created"
      redirect_to @product
    else
      flash[:error] = "Something went wrong"
      render 'new'
    end
  end

  private

  def set_product
    @product = Product.find(params[:product_id])
  end

  def review_params
    params.require(:review).permit(:rating, :description)
  end


end
