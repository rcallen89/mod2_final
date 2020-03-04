class Merchant::MerchantController < Merchant::BaseController

  def show
    @display = DisplayMerchant.new(current_user)
  end
end
