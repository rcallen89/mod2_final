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
end