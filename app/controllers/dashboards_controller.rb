class DashboardsController < ApplicationController
  include DashboardHelper
  before_filter :login_required
  def show
    current_user_dash_items
    # @apprenticeships       = current_user.apprenticeships.where(accepted_status: "confirmed")
    # @pending_learnings     = current_user.apprenticeships.where(accepted_status: "pending")
    # @earning_skills        = current_user.created_skills
    # @apprentice_requests   = current_user.apprentice_requests
    # @upcoming_events       = current_user.confirmed_upcoming_events
    # @current_user_requests = current_user.skill_requests + @pending_learnings
    # make this better
    # @open_requests         = @earning_skills.map(&:categories).flatten.map(&:skill_requests).flatten.select{|x| x.created_at > Time.now - 3.days && x.accepted_status != "confirmed"}
  end

end
