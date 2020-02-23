class Merchant::MerchantController < Merchant::BaseController

  def show
      @orders = current_user.merchants.first.orders.distinct
  end
end
