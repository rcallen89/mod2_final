require 'rails_helper'

RSpec.describe 'New Registration Page', type: :feature do
  context 'as a visiter' do
    it 'shows a form to register a default user' do

      visit '/register'

      fill_in :name, with: 'Benny'
      fill_in :street_address, with: '1234 Main St.'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'CO'
      fill_in :zip, with: '80144'
      fill_in :email, with: 'benny@email.com'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'

      click_on "Register Now"

      expect(current_path).to eq("/profile")
      expect(page).to have_content('Successfully Registered and Logged In')

      # How to test successfully logged in
      # expect(page.current_user).to eq(User.last)
    end

    it 'shows errors for missing information to register a default user' do

      visit '/register'

      fill_in :name, with: 'Benny'
      fill_in :street_address, with: '1234 Main St.'
      fill_in :city, with: 'Denver'
      fill_in :state, with: 'CO'
      fill_in :email, with: 'benny@email.com'
      fill_in :password, with: 'password'
      fill_in :password_confirmation, with: 'password'

      click_on "Register Now"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Zip can't be blank")

      # How to test successfully logged in
      # expect(page.current_user).to eq(User.last)
    end
  end

  it "reroutes back to registration form if email already exists in the system" do
    user = User.create!(name: "Rainbow Unicorn", street_address: "4783 nothing st.", city: "New York", state: "NY", zip: "38402", role: 0, email: "Rainbow_unicorn@example.com", password: "Something")

    require "pry"; binding.pry
    visit '/register'

    assert(User.all.length).to eq(1)

    fill_in :name, with: 'Mary'
    fill_in :street_address, with: '2859 somthing st.'
    fill_in :city, with: 'Boston'
    fill_in :state, with: 'MA'
    fill_in :zip, with: '59032'
    fill_in :email, with: 'Rainbow_unicorn@example.com'
    fill_in :password, with: 'Something'
    fill_in :password_confirmation, with: 'Something'

    click_on "Register Now"

    expect(current_path).to eq(" register")

    assert(User.all.length).to eq(1)

    within "#logged in user" do
      assert(page).to_not have_content("Mary")
    end

    expect(page).to have_content("That email is already tied to an account. Please try another or log in. ")

    within "#registration form" do
      expect(find_field('name').value).to eq 'John'
      expect(find_field('street_address').value).to eq '2859 somthing st.'
      expect(find_field('city').value).to eq 'Boston'
      expect(find_field('state').value).to eq 'MA'
      expect(find_field('zip').value).to eq '59032'
    end
  end
end
