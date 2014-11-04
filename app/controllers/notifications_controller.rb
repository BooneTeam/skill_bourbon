class NotificationsController < ApplicationController

  def index
    notifications = current_user.notifications
  end

  def show
    notification = notification.find(params[:id])
  end

end
