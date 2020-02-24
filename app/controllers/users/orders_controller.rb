class Users::OrdersController < Users::BaseController

  def index
    
  end

  def show
    @order = Order.find(params[:id])
  end

  def update
    order = Order.find(params[:id])
    order.cancel_items
    order.update(status: 3)
    flash[:notice] = "Order #{order.id} Cancelled!"
    redirect_to '/profile'
  end


end