FactoryBot.define do
  factory :user do
    name { "Benny" } 
    street_address { "123 Main Street" }
    city { "CO" }
    state { "Denver" }
    zip { "80144" }
    role { 0 },
    email { "test3@example.com" }
    password { "password" }
  end
end