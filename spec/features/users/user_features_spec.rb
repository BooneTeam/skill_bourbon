require 'rails_helper'

RSpec.describe "the signin process", :type => :feature do
  before :each do
    @user = create(:user)
  end

  it "signs me in from the main login page" do
    visit '/users/sign_in'
    within(".user-container form#new_user") do
      fill_in 'user[username]', :with => @user.username
      fill_in 'user[password]', :with => @user.password
    end
    within(".user-container form#new_user") do
      click_button 'Sign in'
    end
    expect(page).to have_content @user.username
  end

  it "signs me in from the nav login" do
    visit '/'
    within("form#new_user") do
      fill_in 'user[username]', :with => @user.username
      fill_in 'user[password]', :with => @user.password
    end
    click_button 'Sign in'
    expect(page).to have_content @user.username
  end
end
