class CustomSessionsController < Devise::SessionsController
  def create
    resource = if params[:user] && params[:user][:email] == "admin@example.com"
      Admin.find_by(email: params[:user][:email])
    else
      User.find_by(email: params[:user][:email])
    end

    if resource && resource.valid_password?(params[:user][:password])
      sign_in(resource)
      redirect_to resource.is_a?(Admin) ? admin_product_path : products_path
    else
      redirect_to new_user_session_path, alert: 'Invalid email or password'
    end
  end
end
