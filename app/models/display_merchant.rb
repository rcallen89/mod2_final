class DisplayMerchant
  attr_reader :merchant


  def initialize(current_user)
    @merchant = Merchant.find(current_user.merchants.first.id)
  end

  def my_orders
    @merchant.orders.distinct.where('orders.status = 1')
  end

  def my_discounts
    @merchant.discounts
  end
end