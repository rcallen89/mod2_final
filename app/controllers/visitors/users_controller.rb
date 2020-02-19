class Visitors::UsersController < ApplicationController

  def new
  end

  def create
    user = User.new(user_params)
    if user.save
      flash[:notice] = "Successfully Registered and Logged In"
      session[:user_id] = user.id
      redirect_to '/profile'
    else
      flash[:error] = user.errors.full_messages.to_sentence
      redirect_to '/register'
    end
  end

  private

    def user_params
      params.permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

end