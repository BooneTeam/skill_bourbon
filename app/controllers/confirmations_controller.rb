class ConfirmationsController < ApplicationController
include DashboardHelper

  def create
    confirmation = Confirmation.new(params,current_user)
    confirmation = confirmation.confirm
    current_user_dash_items
    respond_to do |format|
      format.html{redirect_to(confirmation[:redirect])}
      format.js { render :action => confirmation[:action], locals: confirmation[:locals]}
    end
  end
end
