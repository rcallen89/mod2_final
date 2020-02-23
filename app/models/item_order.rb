class ItemOrder <ApplicationRecord
  validates_presence_of :item_id, :order_id, :price, :quantity

  belongs_to :item
  belongs_to :order

  def subtotal
    price * quantity
  end

  def is_mine?(merchant_id)
    Item.find(item_id).merchant_id == merchant_id
  end

  def enough_stock?
    Item.find(item_id).inventory >= quantity
  end
end
