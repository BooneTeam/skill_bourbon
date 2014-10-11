class Apprenticeship < ActiveRecord::Base
  validates :user_id, :location_id, :request_description,:skill_id, :apprentice_level, :meeting_date_requested, :presence => true
  belongs_to :user
  belongs_to :skill
  belongs_to :location
  has_many   :notes

  scope :learning, -> {where(apprentice:true, accepted_status: "confirmed")}
  scope :earning,  -> {where(apprentice:false)}
  scope :denied,  -> {where(accepted_status:"denied")}
  scope :confirmed,  -> {where(accepted_status:"confirmed")}
  scope :pending,  -> {where(accepted_status:"pending")}
  scope :confirmed_upcoming,  -> {confirmed.where('meeting_date_scheduled >= ? AND meeting_date_scheduled <= ?', DateTime.now.beginning_of_day, DateTime.now + 15.days)}

  accepts_nested_attributes_for :location
end
