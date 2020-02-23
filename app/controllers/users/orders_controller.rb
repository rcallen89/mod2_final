class Users::OrdersController < Users::BaseController

  def index
    
  end

  def show
    @order = Order.find(params[:id])
  end


end