require 'rails_helper'

RSpec.describe DashboardHelper, :type => :helper do

  # it "should do something" do
    # expect(helper.timeline).to eq @something
  # end
  before :all do
    @user                    = create(:user_with_active_skills)
  end

  it "should instantiate dash variables.. needs to move out of helper" do
    expect(self.current_user_dash_items).to eq @something
  end

  def current_user
      @user
  end

end
