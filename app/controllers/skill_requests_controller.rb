class SkillRequestsController < ApplicationController

  include SearchHelper
  include DashboardHelper

  before_filter :login_required, only:[:new]

  def index
    skills  = search_for(SkillRequest, params).not_confirmed.includes(:location,:categories)
    @skills = skills.paginate(:page => params[:page])
    respond_to do |format|
      format.js { render :partial =>  'refills/cards', :content_type => 'text/html', layout:false }
      format.html
    end
  end

  def show
    @skill_request = SkillRequest.find(params[:id])
  end

  def new
    @categories = Category.order('name')
    @skill_request = SkillRequest.new
    @skill_request.categories.build
    @skill_request.build_location
  end

  def create
    params[:skill_request].merge!({user_id: current_user.id})
    category_ids = params[:skill_request]["category_ids"].split(',')
    params[:skill_request].merge!({category_ids: category_ids})
    @skill_request = SkillRequest.new(skill_request_params)
    @skill_request.location_id = find_location
    if @skill_request.save
      redirect_to dashboard_path
    else
      render 'new'
    end
  end

  def edit
    skill_request = SkillRequest.find(params[:id])
    if current_user == skill_request.user
      @skill_request = skill_request
    else
      redirect_to root_path
    end
  end

  def update
    @skill_request = SkillRequest.find(params['id'])
    params[:skill_request]["category_ids"] ||= []
    category_ids = params[:skill_request]["category_ids"].split(',')
    params[:skill_request].merge!({category_ids: category_ids})
    if @skill_request.update_attributes(skill_request_params)
      @skill_request.location_id = find_location(@skill_request)
      if @skill_request.save
        redirect_to @skill_request
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def destroy
    skill_request = SkillRequest.find(params[:id])
    skill_request.destroy
    redirect_to dashboard_path
  end

  def check_accepted_status
    skill_request = SkillRequest.find(params[:id])
    skill_request.accepted_status = params["skill_request"]["accepted_status"]
    case skill_request.accepted_status
    when "confirmed"
      unless skill_request.has_apprenticeship?
        skill = Skill.create_skill_from_request({skill_request:skill_request,user:current_user, is_active: true})
        apprenticeship = Apprenticeship.new.create_apprenticeship_from_skill({skill:skill,skill_request:skill_request})
        if apprenticeship.valid? && skill.valid?
          skill_request.has_apprenticeship = true
          skill_request.save
        else
          skill_request.accepted_status = "pending"
          skill_request.save
        end
        current_user_dash_items
        respond_to do |format|
          format.html{redirect_to(dashboard_path)}
          format.js { render :action => 'update_dashboard.js.erb'}
        end
      else
        respond_to do |format|
          format.js { render :action => 'skill-request-confirm-error.js.erb', :locals => {:skill_request => skill_request}}
        end
      end
    end
  end

  private

    def skill_request_params
      params.require(:skill_request).permit(:title,:subtitle,:accepted_status,:meeting_date_requested,:skill_level_id,:full_description,:user_id,:location_id,category_ids:[])
    end

    def find_location(skill_request = SkillRequest.new)
      skill_request.location_id.to_s.blank? ? Location.find_or_create_by(params[:skill_request][:location_attributes].symbolize_keys).id : skill_request.location_id
    end

end
