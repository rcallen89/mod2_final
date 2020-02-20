class Users::UsersController < Users::BaseController
 # Restful routes?
  def show
  end

  def edit
    @user = current_user
  end

end