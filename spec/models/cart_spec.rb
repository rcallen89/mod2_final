require 'rails_helper'

RSpec.describe Cart do

  describe "#add_item" do
    it "can add an item to the cart" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")
      cart = Cart.new(Hash.new(0))
      cart.add_item(item2.id.to_s)
      expect(cart.contents).to eq({item2.id.to_s => 1})
    end
  end

  describe "#total_items" do
    it "returns the total amount of items in the card" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)
      expect(cart.total_items).to eq(1)
    end
  end

  describe "#items" do
    it "returns item quantity" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)
      cart.add_item(item1.id.to_s)
      expect(cart.items).to eq({item2 => 1, item1 => 1})
    end
  end

  describe "#subtotal" do
    it "returns the subtotal for a cart" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)
      expect(cart.subtotal(item2)).to eq(30)
    end
  end

  describe "#total" do
    it "returns the total for a cart" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)
      expect(cart.total).to eq(30)
    end
  end

  describe "#limit_reached?" do
    it "lets you know if the cart limit has been reached" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)

      expect(cart.limit_reached?(item2.id.to_s)).to be false

      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)
      cart.add_item(item2.id.to_s)

      expect(cart.limit_reached?(item2.id.to_s)).to be true
    end
  end

  describe "#add_quantity" do
    it "increments the quantity of an item already in your cart" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)
      expect(cart.add_quantity(item2)).to eq(1)
    end
  end

  describe "#subtract_quantity" do
    it "decrements the quantity of an item already in your cart" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)
      cart.add_quantity(item2)
      cart.add_quantity(item2)

      expect(cart.subtract_quantity(item2)).to eq(1)
    end
  end

  describe "#quantity_zero?" do
    it "checks if the quantity in the cart is 0" do
      merchant1 = Merchant.create!(name: "Bunny Rabbit Toys", address: '1234 nothing st', city: "Nowhere", state: "OK", zip: "48993")
      item1 = Item.create!(name: "Toy", description: "bright and colorful", price: 20, inventory: 3, merchant: merchant1, image: "https://hips.hearstapps.com/vader-prod.s3.amazonaws.com/1564437457-71fdrxaapvl-sl1500-1564437437.jpg")
      item2 = Item.create!(name: "Stuffed Animal", description: "Soft and Cuddly", price: 30, inventory: 12, merchant: merchant1, image: "https://www.potterybarnkids.com/products/grey-hippo-nursery-plush-collection/?catalogId=10&sku=3188538&cm_ven=PLA&cm_cat=Google&cm_pla=Toys%20%26%20Play%20%3E%20Rockers%20%26%20Plush%20Toys%20%3E%20Plush%20Toys&cm_ite=3188538&gclid=Cj0KCQiAv8PyBRDMARIsAFo4wK2dZw7bpQDozFrmoLKpp9n6SKcvHR4Rx8wl0r4e7u0cw66VTdzlZicaArlfEALw_wcB#viewLargerSubsetOverlay")

      cart = Cart.new(Hash.new(0))

      cart.add_item(item2.id.to_s)

      expect(cart.quantity_zero?(item2)).to be true
    end
  end
end
