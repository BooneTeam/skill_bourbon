class Apprenticeship < ActiveRecord::Base

  validates  :user_id, :location_id, :request_description,:skill_id, :skill_level_id, :meeting_date_requested, :presence => true
  belongs_to :user
  belongs_to :skill
  belongs_to :location
  has_many   :notes
  has_many   :comments, :as => :commentable, dependent: :destroy
  belongs_to  :skill_level
  scope :learning, -> {where(apprentice:true, accepted_status: "confirmed")}
  scope :earning,  -> {where(apprentice:false)}
  scope :denied,  -> {where(accepted_status:"denied")}
  scope :confirmed,  -> {where(accepted_status:"confirmed")}
  scope :pending,  -> {where(accepted_status:"pending")}
  scope :confirmed_upcoming,  -> {confirmed.where('meeting_date_scheduled >= ? AND meeting_date_scheduled <= ?', DateTime.now.beginning_of_day, DateTime.now + 18.days)}
  has_many :notifications, :as => :notifiable

  accepts_nested_attributes_for :location, :comments

  before_save  :check_accepted_date
  after_create :notify_creator

  def creator
    self.skill.creator
  end

  def check_accepted_date
    set_meeting_date_to_date_requested if has_accepted_dates?
  end

  def has_accepted_dates?
    creator_accept_date && apprentice_accept_date
  end

  def set_meeting_date_to_date_requested
    self.meeting_date_scheduled = self.meeting_date_requested
  end

  def create_apprenticeship_from_skill(apprentice_params = {})
    skill = apprentice_params[:skill]
    skill_request = apprentice_params[:skill_request]
    apprenticeship = self.new({
     user_id:  skill_request.user_id,
     skill_id: skill.id,
     location_id: skill_request.location_id,
     request_description: skill_request.full_description,
     skill_level_id:  skill_request.skill_level.id,
     meeting_date_scheduled: skill_request.meeting_date_scheduled,
     meeting_date_requested: skill_request.meeting_date_requested,
    })
    apprenticeship.save
    apprenticeship.accepted_status = "confirmed"
    change_made_by(apprenticeship.creator)
    apprenticeship.save
    apprenticeship
  end

  #break this out more so if you wnat to explicitly pass :creator you can
  def change_made_by(user)
    case user_role(user)
    when :creator # notify the student that creator madde change
      who_to_notify = self.user
    when :apprentice # notify the creator that student made change
      who_to_notify = self.skill.creator
    end
    self.changed.each do |change|
      self.notifications << Notification.new(:item_changed => change.to_s , to_notify_id: who_to_notify.id)
    end
  end

  def send_comment(user)
    case user_role(user)
    when :creator # notify the student that creator madde change
      who_to_notify = self.user
    when :apprentice # notify the creator that student made change
      who_to_notify = self.skill.creator
    end
    self.notifications << Notification.new(:item_changed => "comment", to_notify_id: who_to_notify.id)
  end

  def set_accepted_date(user)
    case user_role(user)
    when :creator
      creator_accepts_date
    when :apprentice
      apprentices_accepts_date
    end
    change_made_by(user)
  end

  def creator_accepts_date
    self.creator_accept_date = true
  end

  def apprentices_accepts_date
    self.apprentice_accept_date = true
  end

  def user_role(user)
    self.user == user ? :apprentice : :creator
  end

  def notify_creator
    self.notifications << Notification.new(item_changed: "new_apprenticeship",to_notify_id:self.skill.creator_id)
  end

  def changed_comment
    {title: "You just received a commnet",
     description: self.comments.last.content }
  end

  def changed_new_apprenticeship
    {title:"You just got a new student request".freeze,
    description: "Make sure you confirm the request below and start communicating in the comments.".freeze}
  end

  def changed_accepted_status
    {title: "Your skill request has been accepted.".freeze,
     description: "Congratulations! Now start learning.".freeze}
  end

  def changed_creator_accept_date
    {title: "Meeting Date has been accepted by Skill Creator.".freeze,
    description: "The date has been accepted by your teacher. Please accept this date or change it if you haven't already.".freeze}
  end

  def changed_apprentice_accept_date
    {title: "Meeting Date has been accepted by your student".freeze,
    description: "The date has been accepted by your student. Please accept this date or change it you haven't already.".freeze}
  end

  def changed_meeting_date_requested
    {title: "Meeting date has been changed".freeze,
    description: "The time scheduled to meet has been changed please accept or change the meeting date.".freeze}
  end

  def changed_location_id
    {title: "Location has been changed".freeze,
    description: "The meeting location has been changed please accept or change the location.".freeze}
  end

end
