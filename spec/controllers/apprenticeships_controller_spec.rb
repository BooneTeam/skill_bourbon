require 'rails_helper'

RSpec.describe ApprenticeshipsController, :type => :controller do
  it "Show action should render show template" do
    apprenticeship = create(:apprenticeship)
    visit apprenticeship_path(apprenticeship)

    expect(response).to render_template(:show)
  end

  it "redirects to the dashboard upon save" do
    sign_in(User.first)
    apprenticeship    = create(:apprenticeship)
    skill_id          = apprenticeship.skill.id
    location          = apprenticeship.location.attributes
    apprenticeship = {"apprenticeship"=>
        {"skill_id"=> skill_id,
         "request_description"=>apprenticeship.request_description,
         "meeting_date_requested"=>apprenticeship.meeting_date_requested,
         "location"=>location,
         "skill_level_id"=>"2"}}
    post :create, apprenticeship
    expect(response).to redirect_to dashboard_path
  end

  it "new action should render new template if signed_in" do
    sign_in(User.first)

    get :new
    expect(response).to render_template(:new)
  end
end
