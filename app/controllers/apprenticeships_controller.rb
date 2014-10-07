class ApprenticeshipsController < ApplicationController

  def index

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

    private

    def apprenticeship_params
      params.require(:apprenticeship).permit(:request_description,:apprentice_level,:date_requested,:date_scheduled, :skill_id,:location_id)
    end

    def find_location
      params[:apprenticeship][:location_id].to_s.blank? ? Location.find_or_create_by(params[:apprenticeship][:location].symbolize_keys).id : params[:apprenticeship][:location_id]
    end

end
