require 'rails_helper'

RSpec.describe DashboardHelper, :type => :helper do

  # it "should do something" do
    # expect(helper.timeline).to eq @something
  # end

  it "should instantiate dash variables.. needs to move out of helper" do

    expect(self.current_user_dash_items).to eq @something
  end

end
