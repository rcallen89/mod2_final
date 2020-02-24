require 'rails_helper'

RSpec.describe("Order Fullfillment") do
  it "merchant employee can fulfill an order" do
    user = create(:user)
    user.role = 1

    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)
    meg = Merchant.create(name: "Meg's Bike Shop", address: '123 Bike Rd.', city: 'Denver', state: 'CO', zip: 80203)

    mike.users << user

    tire = meg.items.create(name: "Gatorskins", description: "They'll never pop!", price: 2, image: "https://www.rei.com/media/4e1f5b05-27ef-4267-bb9a-14e35935f218?size=784x588", inventory: 12)
    paper = mike.items.create(name: "Lined Paper", description: "Great for writing on!", price: 20, image: "https://cdn.vertex42.com/WordTemplates/images/printable-lined-paper-wide-ruled.png", inventory: 3)
    pencil = mike.items.create(name: "Yellow Pencil", description: "You can write on paper with it!", price: 2, image: "https://images-na.ssl-images-amazon.com/images/I/31BlVr01izL._SX425_.jpg", inventory: 2)
    highlighter = mike.items.create(name: "Pink Highlighter", description: "all the color!", price: 1, image: "http://t0.gstatic.com/images?q=tbn%3AANd9GcTJXpxn5ri-bUeoz3mQ9On7c2PfvL3Ku-ilDUAJ0gv4_0HkUFJBQuriTsUw2yxofI0bSGLbXN4O&usqp=CAc", inventory: 2)

    order = Order.create!(name: "Kelly", address: "2233 Nothing st", city: "Nowhere", state: "NO", zip: "12345", user: user)


    ItemOrder.create(price: 6, quantity: 7, order: order, item: tire)
    ItemOrder.create(price: 2, quantity: 2, order: order, item: paper)
    ItemOrder.create(price: 1, quantity: 2, order: order, item: pencil, status: 1)
    ItemOrder.create(price: 4, quantity: 3, order: order, item: highlighter)


    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/merchant"

    ###CHANGE THIS
    click_on("#{order.id}")

    visit "/merchant/orders/#{order.id}"

    #someone elses shop
    within "#item_order-#{tire.id}" do
      expect(page).to_not have_link("Fulfill Item")
      expect(page).to have_content('None of your business')
    end

    #already fulfilled
    within "#item_order-#{pencil.id}" do
      expect(page).to_not have_link("Fulfill Item")
      expect(page).to have_content('Fulfilled')
    end

    # ordered more than current inventory
    within "#item_order-#{highlighter.id}" do
      expect(page).to_not have_link("Fulfill Item")
    end

    #can be fulfilled
    within "#item_order-#{paper.id}" do
      click_on("Fulfill")
    end

    expect(current_path).to eq("/merchant/orders/#{order.id}")

    #order is now fulfilled
    within "#item_order-#{paper.id}" do
      expect(page).to_not have_link("Fulfill Item")
      expect(page).to have_content('Fulfilled')
    end

    expect(page).to have_content("#{paper.name} on order #{order.id} is now fulfilled")

    visit "/items/#{paper.id}"

    expect(page).to have_content("Inventory: 1")
  end

  it "tells the user why an order cannot be fulfilled" do
    user = create(:user)
    user.role = 1

    mike = Merchant.create(name: "Mike's Print Shop", address: '123 Paper Rd.', city: 'Denver', state: 'CO', zip: 80203)

    mike.users << user

    highlighter = mike.items.create(name: "Pink Highlighter", description: "all the color!", price: 1, image: "http://t0.gstatic.com/images?q=tbn%3AANd9GcTJXpxn5ri-bUeoz3mQ9On7c2PfvL3Ku-ilDUAJ0gv4_0HkUFJBQuriTsUw2yxofI0bSGLbXN4O&usqp=CAc", inventory: 2)

    order = Order.create!(name: "Kelly", address: "2233 Nothing st", city: "Nowhere", state: "NO", zip: "12345", user: user)

    ItemOrder.create(price: 4, quantity: 3, order: order, item: highlighter)

    allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(user)

    visit "/merchant"

    click_on("#{order.id}")

    expect(current_path).to eq("/merchant/orders/#{order.id}")

    # ordered more than current inventory
    within "#item_order-#{highlighter.id}" do
      expect(page).to_not have_link("Fulfill Item")
      expect(page).to have_content("Item cannot be fulfilled")
    end
  end
end
