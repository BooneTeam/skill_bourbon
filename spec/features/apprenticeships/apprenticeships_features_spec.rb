require 'rails_helper'
include Warden::Test::Helpers
Warden.test_mode!

RSpec.describe "apprenticeship", :type => :feature do
  before :each do
    @user                    = create(:user)
    @skill                   = create(:active_skill)
    # @user_with_active_skills = create(:user_with_active_skills)
  end

  context "while NOT signed in" do
   it "cannot see sign up for skill button for a skill/apprenticeship" do
     visit '/skills'
     click_on(@skill.title)
     expect(page).to have_button("Sign Up to learn this skill")
   end
 end

  context "while signed in" do

    before do
      login_as(@user)
    end

   it "can see sign up for a skill/apprenticeship button" do
     visit '/skills'
     click_on(@skill.title)
     expect(page).to have_button("Request Apprenticeship")
   end

    it "can  sign up for a skill/apprenticeship button" do
      visit '/skills'
      click_on(@skill.title)
      click_button("Request Apprenticeship")
      within('#new_apprenticeship_false') do
        fill_in "apprenticeship[meeting_date_requested]", :with => "24/10/2014 17:30"
        find('#apprenticeship_skill_level_id').find(:xpath, 'option[2]').select_option
        click_button("Submit Request")
      end
      expect(@user.skills.count).to eq 1
    end

    #NO similar request button yet. Need some other way of communicating before requesting skill.
    # it "can sign up for a 'similar' skill/apprenticeship but sets it to pending" do
    #   visit '/skills'
    #   click_on(@skill.title)
    #   click_button("Request Similar Apprenticeship")
    #   within('#new_apprenticeship_true') do
    #     fill_in "apprenticeship[meeting_date_requested]", :with => "24/10/2014 17:30"
    #     fill_in "apprenticeship_request_description", :with => "a test thing"
    #     fill_in "apprenticeship_location_address", :with => "456 Stotts"
    #     fill_in "apprenticeship_location_city", :with => "El Paso"
    #     fill_in "apprenticeship_location_state", :with => "TX"
    #     fill_in "apprenticeship_location_zip", :with => "79932"
    #     find('#apprenticeship_skill_level_id').find(:xpath, 'option[2]').select_option
    #     click_button("Submit Request")
    #   end
    #   binding.pry
    #   expect(@user.apprenticeships.count).to eq 1
    #   expect(@user.apprenticeships.first.accepted_status).to eq "pending"
    # end

   describe "can change the date of an apprenticeship" do
     it "Needs to be implemented"
   end

   describe "notifies the teacher of change in date" do
     it "Needs to be implemented"
   end

   describe "notifies the teacher of change in location" do
     it "Needs to be implemented"
   end

   describe "notifies the teacher of acceptance of date" do
     it "Needs to be implemented"
   end

   describe "notifies the student of change in date" do
     it "Needs to be implemented"
   end

   describe "notifies the student of change in location" do
     it "Needs to be implemented"
   end

   describe "notifies the student of acceptance of date" do
     it "Needs to be implemented"
   end

   describe "is commentable" do
     it "Needs to be implemented"
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
