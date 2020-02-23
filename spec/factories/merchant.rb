FactoryBot.define do
  factory :merchant do
    name { "Monster Shop" } 
    address { "123 Main Street" }
    city { "CO" }
    state { "Denver" }
    zip { "80144" }
  end
end