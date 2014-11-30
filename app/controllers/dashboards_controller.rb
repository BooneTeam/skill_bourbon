class DashboardsController < ApplicationController
  include DashboardHelper
  before_filter :login_required
  def show
    current_user_dash_items
  end

end
