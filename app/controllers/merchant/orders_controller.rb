class Merchant::OrdersController < Merchant::BaseController
  def show
    @order = current_user.merchants.first.orders.find(params[:id])
  end
end
