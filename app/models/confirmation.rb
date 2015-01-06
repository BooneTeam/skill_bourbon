class Confirmation
  include Rails.application.routes.url_helpers

  attr_reader :skill_request, :current_user, :params

  def initialize(params = {}, current_user)
    @params        = params
    @current_user  = current_user
  end

  def confirm
    type = params[:type]
    case type
      when 'accept_skill_request'
        create_new_skill_and_apprenticeship
      when 'accept_date'
        accept_date
      else
        raise "No Confirmation method of type #{type}"
    end
  end

  private

  def accept_date
    apprenticeship = Apprenticeship.find(params[:id])
    apprenticeship.set_accepted_date(current_user)
    if apprenticeship.save
      return {redirect: :back}
    end
  end

  #TODO:you may have orphaned skills with no apprenitceships if apprenticeship fails and skill succeeds.. fix this?
  #TODO:set status of skillrequest to confirmed to remove from index and avoid duplicate offers, but allow requester to deny offer and allow others to accept.
  def create_new_skill_and_apprenticeship

    skill_request = SkillRequest.find(params[:id])
    unless skill_request.has_apprenticeship?
      skill          = create_skill(skill_request)
      apprenticeship = create_apprenticeship_from_skill(skill, skill_request)
      if apprenticeship.valid? && skill.valid?
        skill_request.accepted_status = "confirmed"
        skill_request.has_apprenticeship = true
        skill_request.save
      else
        skill_request.accepted_status = "pending"
        skill_request.save
      end
      return {redirect: dashboard_path, action:'update_dashboard.js.erb'}
    else
      return {redirect: skill_request_path(skill_request), action: 'skill-request-confirm-error.js.erb', locals: {:skill_request => skill_request}}
    end
  end

  def create_skill(skill_request)
    Skill.create_skill_from_request({skill_request:skill_request,user:current_user, is_active: true})
  end

  def create_apprenticeship_from_skill(skill,skill_request)
    Apprenticeship.new.create_apprenticeship_from_skill({skill:skill,skill_request:skill_request})
  end

end