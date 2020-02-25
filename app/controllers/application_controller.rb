class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :cart, :current_user, :role, :employee?

  def cart
    @cart ||= Cart.new(session[:cart] ||= Hash.new(0))
  end

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def role 
    current_user.role if current_user
  end

  def employee?
    if current_user
      return current_user.merchants.first == @merchant
    else
      false
    end
  end
end
