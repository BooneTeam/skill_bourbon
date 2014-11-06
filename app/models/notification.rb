class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true
  before_save :create_notification_text

  def create_notification_text
    send("changed_" + item_changed)
  end

  def changed_location_id
    self.title = "Location has been changed"
    self.description = "The meeting location has been changed please accept or change the location."
  end

  def changed_meeting_date_requested
    self.title = "Meeting date has been changed"
    self.description = "The time scheduled to meet has been changed please accept or change the meeting date."
  end

  def changed_creator_accept_date
    self.title = "Meeting Date has been accepted by Skill Creator."
    self.description = "The date has been accepted by your teacher. Please accept this date or change it if you haven't already."
  end

  def changed_apprentice_accept_date
    self.title = "Meeting Date has been accepted by your student"
    self.description = "The date has been accepted by your student. Please accept this date or change it you haven't already."
  end

  def changed_accepted_status
    self.title = "Enrollment in skill has been approved"
    self.description = "Congrats! You've been approved to take this skill! Start communicating with your teaacher now."
  end

  def changed_comment
    self.title = "You Received a new Comment!"
    self.description = "You just received a new comment. Check it out!"
  end

  def changed_new_apprenticeship
    self.title = "You just got a new student request"
    self.description = "Make sure you confirm the request below and start communicating in the comments."
  end
end
