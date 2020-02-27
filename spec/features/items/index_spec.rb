require 'rails_helper'

RSpec.describe "Items Index Page" do
  describe "When I visit the items index page" do
    before(:each) do
      @meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)
      @brian = Merchant.create(name: "Brian's Dog Shop", address: '125 Doggo St.', city: 'Denver', state: 'CO', zip: 80210)
      #
      # @tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      #
      # @pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      # @dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
    end

    it "all items or merchant names are links without active items" do
      visit '/items'

      expect(page).to have_link(@tire.name)
      expect(page).to have_link(@tire.merchant.name)
      expect(page).to have_link(@pull_toy.name)
      expect(page).to have_link(@pull_toy.merchant.name)

    end

    it "I can see a list of all active items "do

      visit '/items'

      within "#item-#{@tire.id}" do
        expect(page).to have_link(@tire.name)
        expect(page).to have_content(@tire.description)
        expect(page).to have_content("Price: $#{@tire.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@tire.inventory}")
        expect(page).to have_link(@meg.name)
        expect(page).to have_css("img[src*='#{@tire.image}']")
      end

      within "#item-#{@pull_toy.id}" do
        expect(page).to have_link(@pull_toy.name)
        expect(page).to have_content(@pull_toy.description)
        expect(page).to have_content("Price: $#{@pull_toy.price}")
        expect(page).to have_content("Active")
        expect(page).to have_content("Inventory: #{@pull_toy.inventory}")
        expect(page).to have_link(@brian.name)
        expect(page).to have_css("img[src*='#{@pull_toy.image}']")
      end

    end

    it 'shouldnt show inactive items' do
      visit '/items'

      expect(page).to_not have_content(@dog_bone.name)
    end

    it "has a link embedded in the item image." do
      visit "/items"

      within "#item-#{@pull_toy.id}" do
        find(:xpath, "//a/img[@alt='Tug toy dog pull 9010 2 800x800']/..").click
        expect(current_path).to eq("/items/#{@pull_toy.id}")
      end
    end

    #Meg is  bike, Brian is dog
    it "I see statistics on the top 5 most popular items." do
      user = create(:user)

      treat_bandolier = @brian.items.create!(name: "Treat Bandolier", description: "Go Rambo with your dog treats.", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      pull_toy = @brian.items.create!(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = @brian.items.create!(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      snoop_dawg = @brian.items.create!(name: "Snoopy Dog Toy", description: "They'll be confused by it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      squeak_toy = @brian.items.create!(name: "Squeaky Toy", description: "It'll annoy everyone but your dog!", price: 12, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      toothbrush = @brian.items.create!(name: "Dog Toothbrush", description: "Brush yo dog's teefers!", price: 5, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      collar = @brian.items.create!(name: "Spiky Collar", description: "Ouch.", price: 3, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)


      tire = @meg.items.create!(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = @meg.items.create!(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      shifter = @meg.items.create!(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 7)
      bike_seat = @meg.items.create!(name: "Bike Seat", description: "Super comfy!", price: 80, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 7)
      bike_horn = @meg.items.create!(name: "Bike Horn", description: "A truck horn for your bike!", price: 80, image: "https://images-na.ssl-images-amazon.com/images/I/4147WWbN64L._SX466_.jpg", inventory: 7)
      bike_basket = @meg.items.create!(name: "Bike Basket", description: "A place to put your junk.", price: 30, image: "https://images-na.ssl-images-amazon.com/images/I/4147WWbN64L._SX466_.jpg", inventory: 7)

      order_1 = Order.create!(name: "Orderz", address: "123 Fake St.", city: "Faketon", state: "FA", zip: 00001, user: user)

      item_order_1 = ItemOrder.create!(item: tire, order: order_1, price: 50, quantity: 3)
      item_order_1 = ItemOrder.create!(item: tire, order: order_1, price: 50, quantity: 15)
      item_order_2 = ItemOrder.create!(item: shifter, order: order_1, price: 150, quantity: 12)
      item_order_3 = ItemOrder.create!(item: treat_bandolier, order: order_1, price: 5, quantity: 11)
      item_order_4 = ItemOrder.create!(item: pull_toy, order: order_1, price: 30, quantity: 5)
      item_order_5 = ItemOrder.create!(item: dog_bone, order: order_1, price: 10, quantity: 3)
      item_order_6 = ItemOrder.create!(item: chain, order: order_1, price: 10, quantity: 1)

      order_2 = Order.create!(name: "Errderrz", address: "321 Real St.", city: "Realton", state: "RE", zip: 10001, user: user)

      item_order_1 = ItemOrder.create!(item: bike_seat, order: order_2, price: 20, quantity: 10)
      item_order_1 = ItemOrder.create!(item: bike_seat, order: order_2, price: 20, quantity: 13)
      item_order_2 = ItemOrder.create!(item: bike_basket, order: order_2, price: 50, quantity: 3)
      item_order_3 = ItemOrder.create!(item: snoop_dawg, order: order_2, price: 100, quantity: 9)
      item_order_4 = ItemOrder.create!(item: squeak_toy, order: order_2, price: 40, quantity: 10)
      item_order_5 = ItemOrder.create!(item: toothbrush, order: order_2, price: 200, quantity: 1)
      item_order_6 = ItemOrder.create!(item: bike_horn, order: order_2, price: 200, quantity: 100)

      visit "/items"

      within "#top-items" do
        expect(page).to have_content("1. Bike Horn")
        expect(page).to have_content("2. Bike Seat")
        expect(page).to have_content("3. Gatorskins")
        expect(page).to have_content("4. Shimano Shifters")
        expect(page).to have_content("5. Treat Bandolier")
      end
    end

    it "I see statistics on the bottom 5 least popular items." do
      treat_bandolier = @brian.items.create(name: "Treat Bandolier", description: "Go Rambo with your dog treats.", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      pull_toy = @brian.items.create(name: "Pull Toy", description: "Great pull toy!", price: 10, image: "http://lovencaretoys.com/image/cache/dog/tug-toy-dog-pull-9010_2-800x800.jpg", inventory: 32)
      dog_bone = @brian.items.create(name: "Dog Bone", description: "They'll love it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      snoop_dawg = @brian.items.create(name: "Snoopy Dog Toy", description: "They'll be confused by it!", price: 21, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      squeak_toy = @brian.items.create(name: "Squeaky Toy", description: "It'll annoy everyone but your dog!", price: 12, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      toothbrush = @brian.items.create(name: "Dog Toothbrush", description: "Brush yo dog's teefers!", price: 5, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)
      collar = @brian.items.create(name: "Spiky Collar", description: "Ouch.", price: 3, image: "https://img.chewy.com/is/image/catalog/54226_MAIN._AC_SL1500_V1534449573_.jpg", active?:false, inventory: 21)


      tire = @meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 100, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      chain = @meg.items.create(name: "Chain", description: "It'll never break!", price: 50, image: "https://www.rei.com/media/b61d1379-ec0e-4760-9247-57ef971af0ad?size=784x588", inventory: 5)
      shifter = @meg.items.create(name: "Shimano Shifters", description: "It'll always shift!", price: 180, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 7)
      bike_seat = @meg.items.create(name: "Bike Seat", description: "Super comfy!", price: 80, image: "https://images-na.ssl-images-amazon.com/images/I/4142WWbN64L._SX466_.jpg", inventory: 7)
      bike_horn = @meg.items.create(name: "Bike Horn", description: "A truck horn for your bike!", price: 80, image: "https://images-na.ssl-images-amazon.com/images/I/4147WWbN64L._SX466_.jpg", inventory: 7)
      bike_basket = @meg.items.create(name: "Bike Basket", description: "A place to put your junk.", price: 30, image: "https://images-na.ssl-images-amazon.com/images/I/4147WWbN64L._SX466_.jpg", inventory: 7)

      order_1 = Order.create(name: "Orderz", address: "123 Fake St.", city: "Faketon", state: "FA", zip: 00001)

      item_order_1 = ItemOrder.create(item: tire, order: order_1, price: 50, quantity: 3)
      item_order_1 = ItemOrder.create(item: tire, order: order_1, price: 50, quantity: 15)
      item_order_2 = ItemOrder.create(item: shifter, order: order_1, price: 150, quantity: 12)
      item_order_3 = ItemOrder.create(item: treat_bandolier, order: order_1, price: 5, quantity: 11)
      item_order_4 = ItemOrder.create(item: pull_toy, order: order_1, price: 30, quantity: 5)
      item_order_5 = ItemOrder.create(item: dog_bone, order: order_1, price: 10, quantity: 3)
      item_order_6 = ItemOrder.create(item: chain, order: order_1, price: 10, quantity: 1)

      order_2 = Order.create(name: "Errderrz", address: "321 Real St.", city: "Realton", state: "RE", zip: 10001)

      item_order_1 = ItemOrder.create(item: bike_seat, order: order_2, price: 20, quantity: 10)
      item_order_1 = ItemOrder.create(item: bike_seat, order: order_2, price: 20, quantity: 13)
      item_order_2 = ItemOrder.create(item: bike_basket, order: order_2, price: 50, quantity: 3)
      item_order_3 = ItemOrder.create(item: snoop_dawg, order: order_2, price: 100, quantity: 9)
      item_order_4 = ItemOrder.create(item: squeak_toy, order: order_2, price: 40, quantity: 10)
      item_order_5 = ItemOrder.create(item: toothbrush, order: order_2, price: 200, quantity: 1)
      item_order_6 = ItemOrder.create(item: bike_horn, order: order_2, price: 200, quantity: 100)

      visit "/items"

      within "#bottom-items" do
        expect(page).to have_content("1. Spiky Collar")
        expect(page).to have_content("2. Chain")
        expect(page).to have_content("3. Dog Toothbrush")
        expect(page).to have_content("4. Dog Bone")
        expect(page).to have_content("5. Pull Toy")
      end
    end
  end
end
