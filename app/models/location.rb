class Location < ActiveRecord::Base
  has_many :apprenticeships
  has_many :skills
  has_many :skill_requests
end
