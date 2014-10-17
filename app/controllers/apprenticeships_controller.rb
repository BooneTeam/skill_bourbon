class ApprenticeshipsController < ApplicationController
  include DashboardHelper
  def index

  end

  def show
    @apprenticeship = Apprenticeship.find(params[:id])
    # @apprenticeship.comments.build
    @skill = @apprenticeship.skill
  end

  def new

  end

  def create
    apprenticeship = Apprenticeship.new(apprenticeship_params)
    #all this should be moved to the Apprentice class as after_create or something
    apprenticeship.user_id = current_user.id
    apprenticeship.accepted_status = "pending"
    apprenticeship.location_id = find_location
    apprenticeship.completion_status = "not-applicable" #could be completed, or in-progess.. these values suck
    if apprenticeship.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def edit

  end

  def destroy

  end

  def update
    apprenticeship = Apprenticeship.find(params[:id])
    if apprenticeship.update_attributes(apprenticeship_params)
      apprenticeship.location_id = find_location(apprenticeship)
      current_user_dash_items
      respond_to do |format|
        format.html { redirect_to(:back) }
        format.js { render  :template => "skill_requests/update_dashboard.js.erb" }
      end
    else
      redirect_to :back
    end
  end

  def accept_date
    apprenticeship = Apprenticeship.find(params[:id])
    if current_user.id == apprenticeship.skill.creator_id
      apprenticeship.creator_accept_date = true
      apprenticeship.save
      respond_to do |format|
        format.html {redirect_to(:back)}
        format.js {}
      end
    elsif current_user.id == apprenticeship.user_id
      apprenticeship.apprentice_accept_date = true
      apprenticeship.save
      respond_to do |format|
        format.html {redirect_to(:back)}
        format.js {}
      end
    end
  end

    private



    def apprenticeship_params
      params.require(:apprenticeship).permit(:request_description,:skill_level_id,:meeting_date_requested,:meeting_date_scheduled, :skill_id,:location_id,:location, :accepted_status, comments_attributes:[])
    end

    def find_location(apprenticeship = Apprenticeship.new)
      apprenticeship.location_id.to_s.blank? ? Location.find_or_create_by(params[:apprenticeship][:location].symbolize_keys).id : apprenticeship.location_id
    end

end
