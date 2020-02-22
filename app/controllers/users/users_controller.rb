class Users::UsersController < Users::BaseController
 # Restful routes?
  def show
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      if params[:user][:password]
        flash[:notice] = "Password Updated!"
        return redirect_to '/profile'
      end
      flash[:notice] = "Profile Updated!"
      redirect_to '/profile'
    else
      flash[:error] = current_user.errors.full_messages.to_sentence
      redirect_to "/profile/edit"
    end
  end

  def change_password
  end

  private

    def user_params
      params.require(:user).permit(:name, :street_address, :city, :state, :zip, :email, :password, :password_confirmation)
    end

end
