class Skill < ActiveRecord::Base
  validates :title, presence: true
  before_save :add_creator_type

  belongs_to :creator, :class_name => 'User'
  belongs_to :location

  has_many :skill_categories
  has_many :categories, through: :skill_categories

  has_many :apprenticeships
  has_many :apprentices, through: :apprenticeships, :source => :user

  accepts_nested_attributes_for :categories, :location
  def add_creator_type
    self.creator_type = "User"
  end

end
