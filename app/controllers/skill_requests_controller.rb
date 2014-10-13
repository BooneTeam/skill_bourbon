class SkillRequestsController < ApplicationController
  # after_filter :check_accepted_status, :only => :update
  include DashboardHelper

  def index
    if params[:search]
      search_hash = params[:search]
      zip   = search_hash[:zip].blank?   ? "%%" : search_hash[:zip]
      city  = search_hash[:city].blank?  ? "%%" : search_hash[:city]
      state = search_hash[:state].blank? ? "%%" : search_hash[:state]
      categories = search_hash[:categories].split(',').map{|x| "\'" + x + "\'"}.join(',')
      locations = Location.where("city LIKE ? AND state LIKE ? AND zip LIKE ?", city,state,zip)
      query = "SELECT * FROM skill_requests
      JOIN locations on locations.id = skill_requests.location_id
      JOIN skill_request_categories on skill_request_categories.skill_request_id = skill_requests.id
      JOIN categories on skill_request_categories.category_id = categories.id
      WHERE locations.zip LIKE '#{zip}'
      AND locations.city LIKE '#{city}'
      AND locations.state LIKE '#{state}'
      AND skill_requests.accepted_status != 'confirmed' "
      unless categories.blank?
        query += " AND categories.id IN (#{categories})"
      end
      results = ActiveRecord::Base.connection.execute(query);
      skill_ids = results.map{|r| r["skill_request_id"]}
      @skills = SkillRequest.find(skill_ids)
      render :partial =>  'refills/cards', :content_type => 'text/html'
    else
      @skills = SkillRequest.where("accepted_status" != 'confirmed')
    end
  end

  def show
    @skill_request = SkillRequest.find(params[:id])
  end

  def new
    if current_user
      @categories = Category.order('name')
      @skill_request = SkillRequest.new
      @skill_request.categories.build
      @skill_request.build_location
    else
      redirect_to new_user_registration_path
    end
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
    @skill_request = SkillRequest.find(params[:id])
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

  def check_accepted_status
    skill_request = SkillRequest.find(params[:id])
    skill_request.accepted_status = params["skill_request"]["accepted_status"]
    case skill_request.accepted_status
    when "confirmed"
      unless skill_request.has_apprenticeship?
        skill = create_skill_from_request(skill_request)
        apprenticeship = create_apprenticeship_from_skill(skill,skill_request)
        if apprenticeship.valid? && skill.valid?
          skill_request.has_apprenticeship = true
          skill_request.save
        else
          skill_request.accepted_status = "pending"
          skill_request.save
        end
        current_user_dash_items
        respond_to do |format|
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
    def create_skill_from_request(skill_request)
      skill = Skill.new(
        title: skill_request.title,
        subtitle: skill_request.subtitle,
        full_description: skill_request.full_description,
        location_id: skill_request.location_id,
        creator_id: current_user.id,
        creator_level:skill_request.apprentice_level + 1)
      skill.categories << skill_request.categories
      skill.save
      skill
    end

    def create_apprenticeship_from_skill(skill, skill_request)
      apprenticeship = Apprenticeship.new(
        user_id:  skill_request.user_id,
        skill_id: skill.id,
        location_id: skill_request.location_id,
        request_description: skill_request.full_description,
        accepted_status:"confirmed",
        apprentice_level:  skill_request.apprentice_level,
        meeting_date_scheduled: skill_request.meeting_date_scheduled,
        meeting_date_requested: skill_request.meeting_date_requested)
      apprenticeship.save
      apprenticeship
    end

    def skill_request_params
      params.require(:skill_request).permit(:title,:subtitle,:accepted_status,:meeting_date_requested,:apprentice_level,:full_description,:user_id,:location_id,category_ids:[])
    end

    def find_location(skill_request = SkillRequest.new)
      skill_request.location_id.to_s.blank? ? Location.find_or_create_by(params[:skill_request][:location_attributes].symbolize_keys).id : skill_request.location_id
    end

end
