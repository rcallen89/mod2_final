class Merchant::MerchantController < Merchant::BaseController

  def show
    @orders = Order.all
  end
end
