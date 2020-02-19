class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id 
      redirect_to '/profile'
    else
      flash[:error] = "Invalid Login"
      render :new
    end
  end


end