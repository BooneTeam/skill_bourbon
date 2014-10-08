class SkillRequestsController < ApplicationController
  def index
    if params[:search]
      search_hash = params[:search]
      zip   = search_hash[:zip].blank?   ? "%%" : search_hash[:zip]
      city  = search_hash[:city].blank?  ? "%%" : search_hash[:city]
      state = search_hash[:state].blank? ? "%%" : search_hash[:state]
      categories = search_hash[:categories].split(',').map{|x| "\'" + x + "\'"}.join(',')
      locations = Location.where("city LIKE ? AND state LIKE ? AND zip LIKE ?", city,state,zip)
      query = "SELECT * FROM skills
      JOIN locations on locations.id = skill_requests.location_id
      JOIN skill_request_categories on skill_request_categories.skill_id = skill_requests.id
      JOIN categories on skill_requests_categories.category_id = categories.id
      WHERE locations.zip LIKE '#{zip}'
      AND locations.city LIKE '#{city}'
      AND locations.state LIKE '#{state}'"
      unless categories.blank?
        query += " AND categories.id IN (#{categories})"
      end
      results = ActiveRecord::Base.connection.execute(query);
      skill_ids = results.map{|r| r["skill_id"]}
      @skills = SkillRequest.find(skill_ids)
      render :partial =>  'refills/cards', :content_type => 'text/html'
    else
      @skills = SkillRequest.all
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
    category_ids = params[:skill_request]["category_ids"].split(',')
    params[:skill_request].merge!({category_ids: category_ids})
    if @skill_request.update_attributes(skill_request_params)
      @skill_request.location_id = find_location
      if @skill_request.save
       redirect_to @skill_request
      else

        render 'edit'
      end
    else
      render 'edit'
    end
  end

  private

    def skill_request_params
      params.require(:skill_request).permit(:title,:subtitle,:full_description,:user_id,:filled,:location_id,category_ids:[])
    end

    def find_location
      params[:skill_request][:location_id].to_s.blank? ? Location.find_or_create_by(params[:skill_request][:location_attributes].symbolize_keys).id : params[:skill_request][:location_id]
    end

end
