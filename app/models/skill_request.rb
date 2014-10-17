class SkillRequest < ActiveRecord::Base
  include Rails.application.routes.url_helpers
  validates :title, :subtitle, :full_description,:user_id,:meeting_date_requested,:location_id, :presence => true

  has_many :skill_request_categories
  has_many :categories, through: :skill_request_categories
  belongs_to  :skill_level

  belongs_to :location
  belongs_to :user

  accepts_nested_attributes_for :location

  def base_uri
    skill_request_path(self)
  end

end
