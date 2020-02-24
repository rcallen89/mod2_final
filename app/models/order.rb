class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :status

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders
  has_many :merchants, through: :items

  enum status: %w( Pending Packaged Shipped Cancelled )

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

end
