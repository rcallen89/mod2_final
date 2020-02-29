class Merchant::DiscountsController < Merchant::BaseController

  def new
    @discount = Discount.new
  end

  def create
    merchant = Merchant.find(current_user.merchants.first.id)
    merchant.discounts.create(discount_params)
    flash[:notice] = 'Discount Created'
    redirect_to '/merchant'
  end

  private

  def discount_params
    params.require(:discount).permit(:percentage, :per_item)  
  end


end