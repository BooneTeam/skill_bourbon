class DashboardsController < ApplicationController

  def show
    @learning_skills       = current_user.apprenticeships.where(accepted_status: "confirmed")
    @pending_learnings     = current_user.apprenticeships.where(accepted_status: "pending")
    @earning_skills        = current_user.created_skills
    @apprentice_requests   = current_user.apprentice_requests
    @upcoming_events       = current_user.confirmed_upcoming_events
    @current_user_requests = current_user.skill_requests + @pending_learnings
    @open_requests         = @earning_skills.map(&:categories).flatten.map(&:skill_requests).flatten
  end

end
