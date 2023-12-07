class ApplicationController < ActionController::Base

  private
  def current_cart
    Cart.find_or_create_by(user_id: current_user.id)
  end
end
