require 'rails_helper'

RSpec.describe "Skill Request", :type => :feature do
  before :each do
    @user                      = create(:user)
    @user_with_active_skills   = create(:user_with_active_skills)
    @user_with_inactive_skills = create(:user_with_inactive_skills)
  end

 describe "can view the index page" do
    pending
  end

 describe "can filter by location" do
    pending
  end

 describe "can filter by up to 3 categories" do
    pending
  end

 describe "can filter by keywords" do
    pending
  end

 describe "can sign up to teach a skill request" do
    pending
  end

 describe "can create a new skill request" do
    pending
  end

 describe "can edit a created skill request" do
    pending
  end

 describe "cannot edit a skill request that it did not create" do
    pending
  end
#   before :each do
#     @user = create(:user)
#   end

#   it "signs me in from the main login page" do
#     visit '/users/sign_in'
#     within(".user-container form#new_user") do
#       fill_in 'user[username]', :with => @user.username
#       fill_in 'user[password]', :with => @user.password
#     end
#     click_button 'Sign in'
#     expect(page).to have_content @user.username
#   end

#   it "signs me in from the nav login" do
#     visit '/'
#     within("form#new_user") do
#       fill_in 'user[username]', :with => @user.username
#       fill_in 'user[password]', :with => @user.password
#     end
#     click_button 'Sign in'
#     expect(page).to have_content @user.username
#   end
end
