class Order <ApplicationRecord
  validates_presence_of :name, :address, :city, :state, :zip, :status

  belongs_to :user
  has_many :item_orders
  has_many :items, through: :item_orders

  enum status: %w( Pending Packaged Shipped Cancelled )

  def grandtotal
    item_orders.sum('price * quantity')
  end

  def total_items
    item_orders.count
  end

  def creation
    created_at.to_date
  end

  def updated
    updated_at.to_date
  end
end
