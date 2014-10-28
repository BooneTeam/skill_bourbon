require 'rails_helper'

RSpec.describe DashboardsController, :type => :controller do

  it "redirects to sign up if user not signed in" do

    get :show
    expect(response).to redirect_to '/users/sign_up'
  end

  it "renders dashboard show when user logged in" do
    sign_in(create(:user))

    get :show
    expect(response).to render_template(:show)
  end
end
