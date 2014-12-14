class Skill < ActiveRecord::Base
  include HashModifiers

  include Rails.application.routes.url_helpers

  scope :ordered_by_date,->{ order("skills.created_at DESC") }
  scope :active,         ->{ where(is_active:true)}
  scope :in_location,    ->(ids) { where('location_id in (?)',ids)}
  scope :in_categories,  ->(ids) { joins(:categories).where('categories.id in (?)', ids)}
  scope :archived,   ->(boolean) {where(archived:boolean)}

  validates :title, :subtitle, :full_description,:creator_id, :skill_level_id, :location_id, :presence => true
  validates_presence_of :categories

  before_save :add_creator_type

  belongs_to :creator, :class_name => 'User'
  belongs_to :location

  has_many :comments, :as => :commentable, dependent: :destroy

  has_many :skill_categories, dependent: :destroy
  has_many :categories, through: :skill_categories

  belongs_to  :skill_level
  belongs_to  :path

  has_many :apprenticeships, dependent: :destroy
  has_many :apprentices, through: :apprenticeships, :source => :user
  has_many :notifications, as: :notifiable
  accepts_nested_attributes_for :categories, :location, :skill_categories

  delegate :username,
           to: :creator,
           prefix: true

  delegate :city,
           :state,
           :zip,
           to: :location,
           prefix: true

  def to_param
    "#{id} #{title}".parameterize
  end

  def created_by?(user)
    user == creator
  end

  def add_creator_type
    self.creator_type = "User"
  end

  def base_uri
    skill_path(self)
  end

  def self.create_skill_from_request(skill_request_params = {})
      skill_request = skill_request_params[:skill_request]
      user = skill_request_params[:user]
      skill = self.new({
                           is_active: true,
                           title:  skill_request.title,
                           subtitle:  skill_request.subtitle,
                           full_description:  skill_request.full_description,
                           location_id:  skill_request.location_id,
                           creator_id:  user.id,
                           skill_level_id: skill_request.skill_level.id,
                           categories: skill_request.categories
                       })
      skill.save
      skill
  end

  #this send comment crap needs to change to something with a block probably
  def send_comment(user)
    self.notifications << Notification.new(item_changed: "comment", to_notify_id: self.creator.id)
  end

  def changed_comment
    {title: "Your skill just received a new comment", description: self.comments.last.content}
  end

  def self.search
    active.archived(false).includes(:location,:categories).ordered_by_date
  end

end
