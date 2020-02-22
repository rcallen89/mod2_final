require 'rails_helper'

RSpec.describe "As an admin,", type: :feature do
    context "I see the same links as a regular user" do
        before :each do
          @user = create(:user, name: "Francisco", role: 2)
          @user2 = create(:user, email: "funny@email.com", role: 0)

            allow_any_instance_of(ApplicationController).to receive(:current_user).and_return(@user)
        end

        it "plus admin and see all user links." do
            visit "/merchants"

            within 'nav' do
                click_link 'Admin Dashboard'
            end
            expect(current_path).to eq("/admin")

            within 'nav' do
                click_link 'See All Users'
            end
            expect(current_path).to eq('/admin/users')
        end

        it "minus a link to shopping cart or count of items in cart." do
            visit "/merchants"

            expect(page).to_not have_link("Cart:")
        end
        it "can see user info after clicking the see all users link" do
          visit "/merchants"

          within 'nav' do
              click_link 'Admin Dashboard'
          end
          expect(current_path).to eq("/admin")

          within 'nav' do
              click_link 'See All Users'
          end
          expect(current_path).to eq('/admin/users')
          expect(page).to have_link(@user.name)
          expect(page).to have_content(@user.role)
          expect(page).to have_content(@user.created_at)

          click_link "Francisco"

          expect(current_path).to eq("/admin/users/#{@user.id}")
        end
    end
end
