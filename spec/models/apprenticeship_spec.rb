require 'rails_helper'

RSpec.describe Apprenticeship, :type => :model do
  pending "add some examples to (or delete) #{__FILE__}"

  describe Apprenticeship, '.has_accepted_dates' do
    context "When only student has accepted" do
      it "should be false" do

      end
    end
    context "When only teacher has accepted" do
      it "should be false" do

      end
    end
    context "When both teacher and student have accepted" do
      it "should be true" do

      end
    end
  end

  describe Apprenticeship, '.check_accepted_date' do
    context "When only student has accepted" do
      it "should be false" do

      end
    end
    context "When only teacher has accepted" do
      it "should be false" do

      end
    end
    context "When both teacher and student have accepted" do
      it "should call set_meeting_date_to_date_requested" do

      end
    end

  end

  describe Apprenticeship, '.set_meeting_date_to_date_requested' do
    it "should change the meeting_date_scheduled to the meeting_date_requested date" do

    end
  end

end
