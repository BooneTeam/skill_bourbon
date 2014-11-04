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
  after_create :set_accepted_status_to_pending

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
    self.user_id =  skill_request.user_id
    self.skill_id = skill.id
    self.location_id = skill_request.location_id
    self.request_description = skill_request.full_description
    self.accepted_status = "confirmed"
    self.skill_level_id =  skill_request.skill_level.id
    self.meeting_date_scheduled = skill_request.meeting_date_scheduled
    self.meeting_date_requested = skill_request.meeting_date_requested
    self.save
    self
  end

  def change_made_by(user)
    binding.pry
    case user_apprenticeship_role(user)
    when :creator # notify the student that creator madde change
      who_to_notify = self.user
    when :apprentice # notify the creator that student made change
      who_to_notify = self.skill.creator
    end
    self.changed.each do |change|
      self.notifications << Notification.new(:item_changed => change.to_s , to_notify_id: who_to_notify.id)
    end
  end

  def set_accepted_date(user)
    case user_apprenticeship_role(user)
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

  def user_apprenticeship_role(user)
    self.user == user ? :apprentice : :creator
  end

end
