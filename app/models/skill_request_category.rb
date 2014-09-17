class SkillRequestCategory < ActiveRecord::Base
  belongs_to :skill_request
  belongs_to :category
end
