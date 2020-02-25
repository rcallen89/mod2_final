class Admin::MerchantsController < Admin::BaseController

  def index
    @merchants = Merchant.all
  end

  def show
    @merchant = Merchant.find(params[:id])
  end

  def update
    merchant = Merchant.find(params[:id])
    merchant.toggle(:enabled?)
    if merchant.enabled?
      merchant.activate_items
      merchant.save
      flash[:notice] = "Merchant #{merchant.name} Enabled"
      redirect_to '/admin/merchants'
    else
      merchant.deactivate_items
      merchant.save
      flash[:notice] = "Merchant #{merchant.name} Disabled"
      redirect_to '/admin/merchants'
    end
  end
end