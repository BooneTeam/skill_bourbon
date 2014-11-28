class Location < ActiveRecord::Base
  #Maybe validate :address
  validates :city, :state, :zip, :presence => true
  has_many :apprenticeships
  has_many :skills
  has_many :skill_requests

  def self.was_changed
    {title: "The location has changed",
    description: "Please review and accept or change."}
  end
end
