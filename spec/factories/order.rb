FactoryBot.define do
  factory :order do
    name { "Order Person" } 
    address { "123 Main Street" }
    city { "CO" }
    state { "Denver" }
    zip { "80144" }
    status { 0 }
    user
  end
end