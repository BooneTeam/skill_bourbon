class Confirmation
  attr_reader :skill_request, :current_user

  def initialize(skill_request,user)
    @skill_request = skill_request
    @current_user          = user
  end
### you may have orphaned skills with no apprenitceships if apprenticeship fails and skill succeeds.. fix this?
  def create_new_skill_and_apprenticeship
    unless skill_request.has_apprenticeship?
      skill          = create_skill
      apprenticeship = create_apprenticeship_from_skill(skill)
      if apprenticeship.valid? && skill.valid?
        skill_request.has_apprenticeship = true
        skill_request.save
      else
        skill_request.accepted_status = "pending"
        skill_request.save
      end
    end
  end

  def create_skill
    Skill.create_skill_from_request({skill_request:skill_request,user:current_user, is_active: true})
  end

  def create_apprenticeship_from_skill(skill)
    Apprenticeship.new.create_apprenticeship_from_skill({skill:skill,skill_request:skill_request})
  end

end