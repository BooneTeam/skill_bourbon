class SkillRequestCategory < ActiveRecord::Base
  # validates :category_id, :skill_request_id, :presence => true
  belongs_to :skill_request
  belongs_to :category
end
