class Admin::UsersController < Admin::BaseController
    def index
      @users = User.all
    end

    def show
      @user_to_view = User.find(params[:id])
    end
end
