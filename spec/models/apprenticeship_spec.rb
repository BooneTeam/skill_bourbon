require 'rails_helper'

RSpec.describe Apprenticeship, :type => :model do
  before :each do
    @apprenticeship = create(:apprenticeship)
  end
  describe Apprenticeship, '#has_accepted_dates' do
    context "When initialized" do
      it "should be false" do
        expect(@apprenticeship.has_accepted_dates?).to eq false
      end
    end

    context "When only student has accepted" do
      it "should be false" do
        @apprenticeship.set_accepted_date(@apprenticeship.user)
        expect(@apprenticeship.apprentice_accept_date).to eq true
        expect(@apprenticeship.creator_accept_date).to eq false
        expect(@apprenticeship.has_accepted_dates?).to eq false
      end
    end

    context "When only teacher has accepted" do
      it "should be false" do
        @apprenticeship.set_accepted_date(@apprenticeship.skill.creator)
        expect(@apprenticeship.apprentice_accept_date).to eq false
        expect(@apprenticeship.creator_accept_date).to eq true
        expect(@apprenticeship.has_accepted_dates?).to eq false
      end
    end
    context "When both teacher and student have accepted" do
      it "should be true" do
        @apprenticeship.set_accepted_date(@apprenticeship.skill.creator)
        @apprenticeship.set_accepted_date(@apprenticeship.user)
        expect(@apprenticeship.has_accepted_dates?).to eq true
      end
    end
  end

  describe Apprenticeship, '.check_accepted_date' do
    context "When only student has accepted" do
      it "should do nothing" do
        expect(@apprenticeship.check_accepted_date). to eq nil
      end
    end
    context "When only teacher has accepted" do
      it "should do nothing" do
        expect(@apprenticeship.check_accepted_date). to eq nil
      end
    end
    context "When both teacher and student have accepted" do
      it "should set_meeting_date_to_date_requested" do
        @apprenticeship.set_accepted_date(@apprenticeship.skill.creator)
        @apprenticeship.set_accepted_date(@apprenticeship.user)
        @apprenticeship.check_accepted_date
        expect(@apprenticeship.meeting_date_scheduled).to eq @apprenticeship.meeting_date_requested
      end
    end

  end

  describe Apprenticeship, '#set_meeting_date_to_date_requested' do
    it "should change the meeting_date_scheduled to the meeting_date_requested date" do
      @apprenticeship.set_meeting_date_to_date_requested
      expect(@apprenticeship.meeting_date_scheduled).to eq @apprenticeship.meeting_date_requested
    end
  end

  describe Apprenticeship, '#who_to_notify' do
    context "when creator is passed" do
      it "should notify the apprentice" do
        response = @apprenticeship.who_to_notify(@apprenticeship.skill.creator)
        expect(response).to eq @apprenticeship.user.id
      end
    end

    context "when apprentice is passed" do
      it "should notify the creator" do
        response = @apprenticeship.who_to_notify(@apprenticeship.user)
        expect(response).to eq @apprenticeship.skill.creator.id
      end
    end
  end

  describe Apprenticeship, '#user_role' do
    context "when creator is passed" do
      it "should return :creator" do
        response = @apprenticeship.user_role(@apprenticeship.skill.creator)
        expect(response).to eq :creator
      end
    end

    context "when apprentice is passed" do
      it "should return :apprentice" do
        response = @apprenticeship.user_role(@apprenticeship.user)
        expect(response).to eq :apprentice
      end
    end
  end

  describe Apprenticeship, '#send_comment' do
    context "when creator is passed" do
      it "should return :creator" do
        response = @apprenticeship.user_role(@apprenticeship.skill.creator)
        expect(response).to eq :creator
      end
    end

    context "when apprentice is passed" do
      it "should return :apprentice" do
        response = @apprenticeship.user_role(@apprenticeship.user)
        expect(response).to eq :apprentice
      end
    end
  end

  describe Apprenticeship, '#notify_creator' do
    context "when new apprenticeship" do
      it "should create a new apprentice notification for skill creator" do
        expect(@apprenticeship.notifications.count).to eq 1
        @apprenticeship.notify_creator
        expect(@apprenticeship.notifications.count).to eq 2
      end
    end
  end

  describe Apprenticeship, '#change_made_by' do
    context "when apprentice is passed" do
      it "should add notification to creator for change made" do
        expect(@apprenticeship.skill.creator.notifications.count).to eq 1
        @apprenticeship.meeting_date_requested  = @apprenticeship.meeting_date_requested + 1.day
        @apprenticeship.change_made_by(@apprenticeship.user)
        expect(@apprenticeship.skill.creator.notifications.count).to eq 2
      end
    end

    context "when creator is passed" do
      it "should add notification to apprentice for change made" do
        @apprenticeship.meeting_date_requested  = @apprenticeship.meeting_date_requested + 1.day
        @apprenticeship.change_made_by(@apprenticeship.skill.creator)
        expect(@apprenticeship.skill.creator.notifications.count).to eq 1
      end
    end
  end

end
