class Admin::AdminController < Admin::BaseController

  def show 
    @orders = Order.all.order(:status)
  end

end