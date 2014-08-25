class Skill < ActiveRecord::Base
  has_many :skill_categories
  has_many :categories, through: :skill_categories
  has_many :user_skills
  has_many :users, through: :user_skills

  # scope :learning, -> { self.where(apprentice: true) }
  # scope :earning,  -> { self.where(apprentice: false) }
end
