class Skill < ActiveRecord::Base

  include Rails.application.routes.url_helpers

  validates :title, :subtitle, :full_description,:creator_id, :creator_level, :location_id, :presence => true
  validates_presence_of :categories

  before_save :add_creator_type

  belongs_to :creator, :class_name => 'User'
  belongs_to :location

  has_many :comments, :as => :commentable

  has_many :skill_categories
  has_many :categories, through: :skill_categories

  belongs_to  :skill_level

  has_many :apprenticeships
  has_many :apprentices, through: :apprenticeships, :source => :user

  accepts_nested_attributes_for :categories, :location, :skill_categories
  def add_creator_type
    self.creator_type = "User"
  end

  def base_uri
    skill_path(self)
  end

end
