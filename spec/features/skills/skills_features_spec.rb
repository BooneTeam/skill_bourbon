require 'rails_helper'

RSpec.describe "Skills", :type => :feature do
  before :each do
    @user                      = create(:user)
    @user_with_active_skills   = create(:user_with_active_skills)
    @user_with_inactive_skills = create(:user_with_inactive_skills)
  end

  # context "while NOT signed in" do
    describe "cannot sign up for a skill/apprenticeship" do
      it "Need to Implement"
        # pending("something else getting finished")
        # visit '/skills'
      # end
    end
  # end

  context "while signed in" do
    describe "index page"   do
      it "can see all active skills" do
        visit '/skills'
        expect(page).to have_css(".title", count: @user_with_active_skills.created_skills.count)
        @user_with_active_skills.created_skills.each do |skill|
          expect(page).to have_css(".title", text: skill.title)
        end
      end
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

    describe "can sign up to learn a skill" do
      pending
    end

    describe "can create a new skill" do
      pending
    end

    describe "can edit a created skill" do
      pending
    end

    describe "cannot edit a skill that it did not create" do
      pending
    end

  end

end
