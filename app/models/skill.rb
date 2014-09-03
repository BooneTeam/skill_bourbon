class Skill < ActiveRecord::Base

  before_save :add_creator_type

  belongs_to :creator, :class_name => 'User'

  has_many :skill_categories
  has_many :categories, through: :skill_categories

  has_many :apprenticeships
  has_many :apprentices, through: :apprenticeships, :source => :user

  def add_creator_type
    self.creator_type = "User"
  end

end
