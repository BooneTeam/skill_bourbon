class NotificationsController < ApplicationController

  def index
    notifications = current_user.notifications
  end

  def show
    notification = notification.find(params[:id])
  end

  def destroy
    notification = Notification.find(params[:id])
    if notification.destroy
      redirect_to :back
    end
  end

end
