class Path < ActiveRecord::Base
  has_many   :skills
  belongs_to :user

  def to_param
  	"#{id} #{name}".parameterize
  end
end
