class Users::BaseController < ApplicationController
    before_action :require_users

    def require_users 
        render file: "/public/404" unless current_user
    end
end