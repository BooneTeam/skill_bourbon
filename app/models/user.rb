class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,:lockable

  has_many :created_skills, :as => :creator, :class_name => "Skill"
  has_many :apprentice_requests, through: :created_skills, :source => :apprenticeships

  has_many :skill_requests

  has_many :apprenticeships
  has_many :skills, through: :apprenticeships
  has_many :notes,  through: :apprenticeships

  def confirmed_upcoming_events
    self.apprenticeships.confirmed_upcoming + self.apprentice_requests.confirmed_upcoming
  end

end
