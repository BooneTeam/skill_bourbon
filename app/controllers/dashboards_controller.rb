class DashboardsController < ApplicationController

  def show
    @learning_skills     = current_user.apprenticeships
    @earning_skills      = current_user.created_skills
    @apprentice_requests = current_user.apprentice_requests
    @upcoming_events     = current_user.confirmed_upcoming_events
  end

end
