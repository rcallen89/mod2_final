class Merchant::MerchantController < Merchant::BaseController

  def show
    @orders = current_user.merchants.first.orders.distinct.where('orders.status = 1')
  end
end
