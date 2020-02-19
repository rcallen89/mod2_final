require 'rails_helper'

RSpec.describe "As a visitor," do
  context "when I try to access a restriced path" do
    it "then I see a 404 error." do
      visit '/merchant/'

      expect(page).to have_content("")
    end
  end
end
