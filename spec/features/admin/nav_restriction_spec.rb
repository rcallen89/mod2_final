require 'rails_helper'

RSpec.describe "As an admin,", type: :feature do 
    context "when I try to access a restricted page" do 
        before :each do
            @user = create(:user, role: 2)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        end
        
        it "then I get a 404 error." do 
            visit "/merchant"
            expect(page).to have_content("The page you were looking for doesn't exist.")

            visit "/cart"
            expect(page).to have_content("The page you were looking for doesn't exist.")
        end 
    end 
end  