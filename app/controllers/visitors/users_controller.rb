class Visitors::UsersController < ApplicationController

  def new
    if current_user
      flash[:notice] = "You are already logged in."
      route_by_role(current_user)
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      flash[:notice] = "Successfully Registered and Logged In"
      redirect_to '/profile'
    else
      params[:user].delete(:email)
      flash[:error] = @user.errors.full_messages.to_sentence
      render :new
    end
  end

  private

    def user_params
      params.require(:user).permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

    def route_by_role(user)
      if user.role == 'User'
        redirect_to '/profile'
      elsif user.role == 'MerchantEmployee'
        redirect_to '/merchant'
      else
        redirect_to '/admin'
      end
    end

end
