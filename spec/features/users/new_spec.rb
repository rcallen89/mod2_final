require 'rails_helper'

RSpec.describe 'New Registration Page', type: :feature do
  context 'as a visiter' do
    it 'shows a form to register a default user' do

      visit '/register'
      save_and_open_page
      fill_in :Name, with: 'Benny'
      fill_in :street_address, with: '1234 Main St.'
      fill_in :City, with: 'Denver'
      fill_in :State, with: 'CO'
      fill_in :Zip, with: '80144'
      fill_in :Email, with: 'benny@email.com'
      fill_in :Password, with: 'password'
      fill_in :Password_confirmation, with: 'password'

      click_on "Register Now"

      expect(current_path).to eq("/profile")
      expect(page).to have_content('Successfully Registered and Logged In')

      # How to test successfully logged in
      # expect(page.current_user).to eq(User.last)
    end

    it 'shows errors for missing information to register a default user' do

      visit '/register'

      fill_in :Name, with: 'Benny'
      fill_in :Address, with: '1234 Main St.'
      fill_in :City, with: 'Denver'
      fill_in :State, with: 'CO'
      fill_in :Email, with: 'benny@email.com'
      fill_in :Password, with: 'password'
      fill_in :Password_confirmation, with: 'password'

      click_on "Register Now"

      expect(current_path).to eq("/register")
      expect(page).to have_content("Zip can't be blank")

      # How to test successfully logged in
      # expect(page.current_user).to eq(User.last)
    end

  it "reroutes back to registration form if email already exists in the system" do
    user = User.create!(name: "Rainbow Unicorn", street_address: "4783 nothing st.", city: "New York", state: "NY", zip: "38402", role: 0, email: "Rainbow_unicorn@example.com", password: "Something")

    visit '/register'

    expect(User.all.length).to eq(1)

    fill_in :Name, with: 'Mary'
    fill_in :Street_address, with: '2859 somthing st.'
    fill_in :City, with: 'Boston'
    fill_in :State, with: 'MA'
    fill_in :Zip, with: '59032'
    fill_in :Email, with: 'Rainbow_unicorn@example.com'
    fill_in :Password, with: 'Something'
    fill_in :Password_confirmation, with: 'Something'

    click_on "Register Now"

    expect(current_path).to eq("/register")

    # within "#logged in user" do
      expect(page).to_not have_content("Mary")
    # end

    expect(page).to have_content("Email has already been taken")

    # within "#registration form" do
      expect(find_field('name').value).to eq 'John'
      expect(find_field('street_address').value).to eq '2859 somthing st.'
      expect(find_field('city').value).to eq 'Boston'
      expect(find_field('state').value).to eq 'MA'
      expect(find_field('zip').value).to eq '59032'
    # end
    end
  end
end
