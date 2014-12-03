require 'rails_helper'

RSpec.describe SkillsController, :type => :controller do
  it "index action should render index template" do
    get :index
    # , :advertiser_id => @advertiser, :order_id => @order
    expect(response).to render_template(:index)
  end

  it "new action should redirect to sign_up url if not signed in" do

    get :new
    expect(response).to redirect_to '/users/sign_up'
  end

  it "new action should render new template if signed_in" do
    sign_in(User.first)

    get :new
    expect(response).to render_template(:new)
  end
end
