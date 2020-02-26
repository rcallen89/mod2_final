class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :status

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
  has_many :merchants, through: :items

  enum status: %w( Packaged Pending Shipped Cancelled )

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_items
    item_orders.sum(:quantity)
  end

  def creation
    created_at.to_date
  end

  def updated
    updated_at.to_date
  end

  def item_table
    items.joins(:item_orders).select('items.*, item_orders.quantity as qty').distinct
  end

  def cancel_items
    item_orders.each do |item_order|
      item_order.item.inventory += item_order.quantity if item_order.status = "Fulfilled"
    end
  end

  def current_status
    if self.status == "Pending"
      self.update(status: 0) if item_orders.select(:status).distinct.pluck(:status) == ["Fulfilled"]
    end
    self.status
  end

  def items_by_merchant(merchant_id)
    item_orders.joins(:item).where("items.merchant_id = #{merchant_id}").sum(:quantity)
  end

  def grandtotal_by_merchant(merchant_id)
    item_orders.joins(:item).where("items.merchant_id = #{merchant_id}").sum('item_orders.price * item_orders.quantity')
  end
end
