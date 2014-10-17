require 'rails_helper'

RSpec.describe StaticPagesController, :type => :controller do
  it "index action should render index template" do
    get :home
    # , :advertiser_id => @advertiser, :order_id => @order
    expect(response).to render_template(:home)
  end

  # it "show action should render show template" do
  #   get :show
  #   response.should render_template(:show)
  # end

  # it "new action should render new template" do
  #   sign_in

  #   get :new
  #   expect(response).to render_template(:new)
  # end
end
