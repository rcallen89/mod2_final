require 'rails_helper'

RSpec.describe "As an merchant employee,", type: :feature do
    before :each do
        @user = create(:user, name: "Francisco", role: 1)
        @bike_shop = Merchant.create(name: "Brian's Bike Shop", address: '123 Bike Rd.', city: 'Richmond', state: 'VA', zip: 80203)

        @bike_shop.users << @user

        allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
    end

    describe "then I visit merchant dashboard" do
        it "then I see a link to view my own items that takes me to /merchant/items" do
            visit "/merchant"
            click_link "My Items"
            expect(current_path).to eq(merchant_items_path)
        end
    end

    describe "when I visit my merchant dashboard" do
        it "then I see the name and full address of the merchant I work for. " do
            visit "/merchant"

            expect(page).to have_content("Brian's Bike Shop")
            expect(page).to have_content("123 Bike Rd.")
            expect(page).to have_content("Richmond")
            expect(page).to have_content("VA")
            expect(page).to have_content("80203")
        end
    end

    it "when user is merchantemployee only shows the outstanding orders for this vendor" do

      user = create(:user)
      user.role = 1

      mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
      meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

      mike.users << user

      tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 2, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
      paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
      pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 2)
      highlighter = mike.items.create(name: "Pink Highlighter", description: "all the color!", price: 1, image: "http://t0.gstatic.com/images?q=tbn%3AANd9GcTJXpxn5ri-bUeoz3mQ9On7c2PfvL3Ku-ilDUAJ0gv4_0HkUFJBQuriTsUw2yxofI0bSGLbXN4O&usqp=CAc", inventory: 2)

      order1 = Order.create!(name: "Kelly", address: "2233 Nothing st", city: "Nowhere", state: "NO", zip: "12345", user: user)
      order2 = Order.create!(name: "Beccy", address: "3456 Something st", city: "Somewhere", state: "SO", zip: "789896", user: user)
      order3 = Order.create!(name: "Carmen", address: "4356 Exists st", city: "Exist", state: "EX", zip: "405093", user: user)
      order4 = Order.create!(name: "Sandiego", address: "68940 Somewhere st", city: "Somewhere", state: "SO", zip: "40034", user: user)


      ItemOrder.create(price: 6, quantity: 7, order: order1, item: tire)
      ItemOrder.create(price: 2, quantity: 2, order: order1, item: paper)
      ItemOrder.create(price: 1, quantity: 2, order: order1, item: pencil)
      ItemOrder.create(price: 4, quantity: 3, order: order1, item: highlighter)

      ItemOrder.create(price: 6, quantity: 2, order: order2, item: tire)
      ItemOrder.create(price: 5, quantity: 2, order: order2, item: paper)
      ItemOrder.create(price: 8, quantity: 2, order: order2, item: pencil)
      ItemOrder.create(price: 2, quantity: 2, order: order2, item: highlighter)

      ItemOrder.create(price: 9, quantity: 2, order: order3, item: tire)

      ItemOrder.create(price: 2, quantity: 7, order: order4, item: tire)


      allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

      visit "/merchant"

      expect(page).to have_link("#{order1.id}")
      expect(page).to have_content("#{order1.date_created}")
      expect(page).to have_content("#{order1.quantity}")
      expect(page).to have_content("#{order1.total_value}")
      expect(page).to have_link("#{order2.id}")
      expect(page).to have_content("#{order2.date_created}")

      expect(page).to_not have_content("#{order3.id}")
      expect(page).to_not have_content("#{order4.id}")
    end
end
