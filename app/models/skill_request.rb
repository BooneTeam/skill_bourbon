class SkillRequest < ActiveRecord::Base
  has_many :skill_request_categories
  has_many :categories, through: :skill_request_categories

  belongs_to :location
  belongs_to :user
end
