class Location < ActiveRecord::Base
  #Maybe validate :address
  validates :city, :state, :zip, :presence => true
  has_many :apprenticeships
  has_many :skills
  has_many :skill_requests
end
