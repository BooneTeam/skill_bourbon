class UserSkill < ActiveRecord::Base
  belongs_to :user
  belongs_to :skill

  scope :learning, -> {where(apprentice:true)}
  scope :earning,  -> {where(apprentice:false)}
end
