class Apprenticeship < ActiveRecord::Base
  before_save :check_accepted_date

  validates  :user_id, :location_id, :request_description,:skill_id, :skill_level_id, :meeting_date_requested, :presence => true
  belongs_to :user
  belongs_to :skill
  belongs_to :location
  has_many   :notes
  has_many   :comments, :as => :commentable
  has_one    :skill_level
  scope :learning, -> {where(apprentice:true, accepted_status: "confirmed")}
  scope :earning,  -> {where(apprentice:false)}
  scope :denied,  -> {where(accepted_status:"denied")}
  scope :confirmed,  -> {where(accepted_status:"confirmed")}
  scope :pending,  -> {where(accepted_status:"pending")}
  scope :confirmed_upcoming,  -> {confirmed.where('meeting_date_scheduled >= ? AND meeting_date_scheduled <= ?', DateTime.now.beginning_of_day, DateTime.now + 15.days)}

  accepts_nested_attributes_for :location, :comments

  def check_accepted_date
    change_date_scheduled if has_accepted_dates?
  end

  def has_accepted_dates?
    creator_accept_date && apprentice_accept_date
  end

  def change_date_scheduled
    self.meeting_date_scheduled = self.meeting_date_requested
  end

end
