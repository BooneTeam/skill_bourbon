class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  validates :username, :uniqueness => true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:lockable

  has_many :created_skills, :as => :creator, :class_name => "Skill"
  has_many :apprentice_requests, through: :created_skills, :source => :apprenticeships
  has_many :paths
  has_many :skill_requests
  has_many :comments
  has_many :apprenticeships
  has_many :skills, through: :apprenticeships
  has_many :notes,  through: :apprenticeships
  has_many :notifications, :as => :to_notify
  def confirmed_upcoming_events
    self.apprenticeships.confirmed_upcoming + self.apprentice_requests.confirmed_upcoming
  end

  def is_apprentice?(item)
    apprenticeships.include?(item) || skills.include?(item)
  end

end
