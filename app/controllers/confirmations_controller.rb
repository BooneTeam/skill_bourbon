class ConfirmationsController < ApplicationController
include DashboardHelper

  def create
    skill_request = SkillRequest.find(params[:skill_request_id])
    unless skill_request.has_apprenticeship?
      Confirmation.new(skill_request,current_user)
      current_user_dash_items
      respond_to do |format|
        format.html{redirect_to(dashboard_path)}
        format.js { render :action => 'update_dashboard.js.erb'}
      end
    else
      respond_to do |format|
        format.js { render :action => 'skill-request-confirm-error.js.erb', :locals => {:skill_request => skill_request}}
      end
    end
  end

end
