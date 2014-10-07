class SkillCategory < ActiveRecord::Base
  # validates :category_id, :skill_id, :presence => true

  belongs_to :skill
  belongs_to :category
end
