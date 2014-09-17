class Location < ActiveRecord::Base
  has_many :apprenticeships
  has_many :skills

end
