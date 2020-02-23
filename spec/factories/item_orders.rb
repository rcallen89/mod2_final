FactoryBot.define do
  factory :item_order do
    item 
    price { item.price }
    quantity { 2 }
    order
  end
end