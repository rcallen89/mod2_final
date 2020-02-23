FactoryBot.define do
  factory :item do
    name { "Dog Bone" } 
    description { "A dog bone" }
    price { 10 }
    image { "https://www.valupets.com/media/catalog/product/cache/1/image/650x/040ec09b1e35df139433887a97daa66f/l/a/large_rubber_dog_pull_toy.jpg" }
    inventory { 7 }
    merchant
  end
end