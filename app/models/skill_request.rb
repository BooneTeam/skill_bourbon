class SkillRequest < ActiveRecord::Base
  validates :title, :subtitle, :full_description,:user_id, :location_id, :presence => true

  has_many :skill_request_categories
  has_many :categories, through: :skill_request_categories

  belongs_to :location
  belongs_to :user

  accepts_nested_attributes_for :location
end
