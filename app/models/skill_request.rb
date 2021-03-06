class SkillRequest < ActiveRecord::Base
  include HashModifiers

  include Rails.application.routes.url_helpers

  scope :not_confirmed, ->{ where.not(accepted_status:'confirmed')}
  scope :in_location, ->(ids) { where('location_id in (?)',ids)}
  scope :in_categories,  ->(ids) { joins(:categories).where('categories.id in (?)', ids)}

  validates :title, :subtitle, :full_description,:user_id,:meeting_date_requested,:location_id, :presence => true

  has_many :skill_request_categories, dependent: :destroy
  has_many :categories, through: :skill_request_categories
  belongs_to  :skill_level

  belongs_to :location
  belongs_to :user

  accepts_nested_attributes_for :location

  delegate :city,
           :state,
           :zip,
           to: :location,
           prefix: true

  def to_param
    "#{id} #{title}".parameterize
  end

  def base_uri
    skill_request_path(self)
  end

  def self.search
    not_confirmed.includes(:location,:categories)
  end

  def changed_accepted_status
    {title: "Enrollment in skill has been approved".freeze,
    description:"Congrats! You've been approved to take this skill! Start communicating with your teacher now.".freeze}
  end
end
