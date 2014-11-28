class Notification < ActiveRecord::Base
  belongs_to :notifiable, :polymorphic => true
  # before_save :create_notification_text

  # def create_notification_text
    # send("changed_" + item_changed)
  # end

  #creates text for notifications base on and changed_ method in model that was changed and @notification#item_changed
  def meta_desc
    @notifiable = notifiable
    shit = Notification.define_notification_text("changed_#{item_changed}")
    self.send(shit)
  end

  def self.define_notification_text(name)
    if !name.match(/changed_(.*)_id/).nil?
      caps = name.match(/changed_(.*)_id/).captures[0]
      define_method(caps) do
        return caps.capitalize.constantize.send("was_changed")
      end
    else
      define_method(name) do
        return @notifiable.send(name)
      end
    end
  end

  # def changed_location_id
  #   self.title = "Location has been changed".freeze
  #   self.description = "The meeting location has been changed please accept or change the location.".freeze
  # end

  # def changed_meeting_date_requested
  #   self.title = "Meeting date has been changed".freeze
  #   self.description = "The time scheduled to meet has been changed please accept or change the meeting date.".freeze
  # end
  #
  # def changed_creator_accept_date
  #   self.title = "Meeting Date has been accepted by Skill Creator.".freeze
  #   self.description = "The date has been accepted by your teacher. Please accept this date or change it if you haven't already.".freeze
  # end
  #
  # def changed_apprentice_accept_date
  #   self.title = "Meeting Date has been accepted by your student".freeze
  #   self.description = "The date has been accepted by your student. Please accept this date or change it you haven't already.".freeze
  # end

  # def changed_accepted_status
  #   self.title = "Enrollment in skill has been approved".freeze
  #   self.description = "Congrats! You've been approved to take this skill! Start communicating with your teacher now.".freeze
  # end
  #
  # def changed_comment
  #   self.title = "You Received a new Comment!".freeze
  #   self.description = "You just received a new comment. Check it out!".freeze
  # end
  #
  # def changed_new_apprenticeship
  #   self.title = "You just got a new student request".freeze
  #   self.description = "Make sure you confirm the request below and start communicating in the comments.".freeze
  # end
end
