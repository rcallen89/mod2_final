require 'rails_helper'

RSpec.describe "As a visitor,", type: :feature do
  context "when I try to access a restriced path" do
    it "then I see a 404 error." do
      visit '/merchant'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/admin'
      expect(page).to have_content("The page you were looking for doesn't exist.")

      visit '/profile'
      expect(page).to have_content("The page you were looking for doesn't exist.")
    end
  end
end
