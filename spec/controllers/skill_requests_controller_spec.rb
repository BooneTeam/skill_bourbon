require 'rails_helper'

RSpec.describe SkillRequestsController, :type => :controller do
  it "index action should render index template" do
    get :index
    # , :advertiser_id => @advertiser, :order_id => @order
    expect(response).to render_template(:index)
  end

  it "should redirect to sign_up url if not signed in" do

    get :new
    expect(response).to redirect_to '/users/sign_up'
  end

  it "new action should render new template" do
    sign_in

    get :new
    expect(response).to render_template(:new)
  end
end
