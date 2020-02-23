class ItemOrdersController<ApplicationController
  def update
    item_order = ItemOrder.find(params[:id])
    item_order.toggle(:fulfilled?)
    item_order.item.inventory -= item_order.quantity
    item_order.item.save
    item_order.save
    flash[:message] = "#{item_order.item.name} on order #{item_order.order_id} is now fulfilled"
    redirect_to "/merchant/orders/#{item_order.order_id}"
  end

  # private
  #   def item_order_params
  #     params.permit(:fulfilled?)
  #   end
end
