class Apprenticeship < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill
  belongs_to :location
  has_many   :notes

  scope :learning, -> {where(apprentice:true)}
  scope :earning,  -> {where(apprentice:false)}
  scope :denied,  -> {where(accepted_status:"denied")}
  scope :confirmed,  -> {where(accepted_status:"confirmed")}
  scope :pending,  -> {where(accepted_status:"pending")}
  scope :confirmed_upcoming,  -> {confirmed.where('date_scheduled >= ? AND date_scheduled <= ?', DateTime.now.beginning_of_day, DateTime.now + 15.days)}

end
