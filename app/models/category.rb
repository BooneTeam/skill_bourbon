class Category < ActiveRecord::Base
 # validates :col_a, :col_b, :col_c, :presence => true
 scope :finder, lambda { |q| where("name like :q", q: "%#{q}%") }

 has_many :skill_categories
 has_many :skills, through: :skill_categories

 has_many :skill_request_categories
 has_many :skill_requests,through: :skill_request_categories

  def as_json(options)
    { id: id, text: name }
  end

end
