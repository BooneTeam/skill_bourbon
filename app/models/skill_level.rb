class SkillLevel < ActiveRecord::Base
  has_many :skills
  has_many :apprenticeships
  has_many :skill_requests
end
