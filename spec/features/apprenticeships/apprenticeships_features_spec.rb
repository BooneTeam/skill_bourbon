require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe "apprenticeship", :type => :feature do
  before :each do
    @user                    = create(:user)
    @user_with_active_skills = create(:user_with_active_skills)
  end
 context "while NOT signed in" do
   it "cannot sign up for a skill/apprenticeship" do
     login_as(@user)
     visit '/skills'
     pending "Need to Implement"
   end
 end
 context "while signed in" do
   it "can sign up for a skill/apprenticeship" do

     pending "Need to Implement"
   end

   it "can sign up for a 'similar' skill/apprenticeship" do
     pending "Need to Implement"
   end

   it "can change the date of an apprenticeship" do
     pending "Need to Implement"
   end

   it "notifies the teacher of change in date" do
     pending "Need to Implement"
   end

   it "notifies the teacher of change in location" do
     pending "Need to Implement"
   end

   it "notifies the teacher of acceptance of date" do
     pending "Need to Implement"
   end

   it "notifies the student of change in date" do
     pending "Need to Implement"
   end

   it "notifies the student of change in location" do
     pending "Need to Implement"
   end

   it "notifies the student of acceptance of date" do
     pending "Need to Implement"
   end

   it "is commentable" do
     pending "Need to Implement"
   end
end

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
