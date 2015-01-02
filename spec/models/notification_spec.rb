require 'rails_helper'

RSpec.describe Notification, :type => :model do

  describe Notification, '#meta_desc' do
    before do
      @apprenticeship = create(:apprenticeship)
    end
    context "when an apprenticeship is created" do
      it "calls the method foo_changed" do
        expect(@apprenticeship.skill_creator.notifications.first.meta_desc).to eq({:title=>"You just got a new student request",
            :description=>"Make sure you confirm the request below and start communicating in the comments."})
      end
    end
  end

  describe Notification, '::define_notification_text' do

  end
end
