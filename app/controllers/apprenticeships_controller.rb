class ApprenticeshipsController < ApplicationController
  include DashboardHelper
  def index

  end

  def show
    @apprenticeship = Apprenticeship.find(params[:id])
    @skill = @apprenticeship.skill
  end

  def new

  end

  def create
    apprenticeship = Apprenticeship.new(apprenticeship_params)
    apprenticeship.user_id = current_user.id
    apprenticeship.location_id = find_location
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
    if params[:apprenticeship][:location_attributes]
      apprenticeship.location_id = location_by_attributes(params[:apprenticeship][:location_attributes].except(:id))
      params[:apprenticeship].delete(:location_attributes)
    end
    apprenticeship.assign_attributes(apprenticeship_params)
    if apprenticeship.changed?
      apprenticeship.change_made_by(current_user)
    end
    apprenticeship.save
    current_user_dash_items
    respond_to do |format|
      format.html { redirect_to(:back) }
      format.js { render  :template => "skill_requests/update_dashboard.js.erb" }
    end
  end

  def accept_date
    apprenticeship = Apprenticeship.find(params[:id])
    apprenticeship.set_accepted_date(current_user)
    apprenticeship.save
    respond_to do |format|
      format.html {redirect_to(:back)}
      format.js {}
    end
  end

    private

    def apprenticeship_params
      params.require(:apprenticeship).permit(:request_description,:skill_level_id,:meeting_date_requested,:meeting_date_scheduled, :skill_id,:location_id,:location, :accepted_status, comments_attributes:[])
    end

    def find_location(apprenticeship = Apprenticeship.new)
      apprenticeship.location_id.to_s.blank? ? Location.find_or_create_by(params[:apprenticeship][:location].symbolize_keys).id : apprenticeship.location_id
    end

    def location_by_attributes(location)
      Location.find_or_create_by(location.symbolize_keys).id
    end

end
