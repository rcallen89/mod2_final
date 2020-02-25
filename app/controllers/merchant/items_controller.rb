class Merchant::ItemsController < Merchant::BaseController 

    def index
      @items = current_user.merchants.first.items
    end 

    def update
      item = Item.find(params[:id])
      item.toggle(:active?)
      item.save
      if item.active?
        flash[:notice] = "#{item.name} now available for sale"
      else
        flash[:notice] = "#{item.name} is no longer for sale"
      end
      redirect_to '/merchant/items'
    end
end