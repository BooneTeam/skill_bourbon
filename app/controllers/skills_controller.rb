class SkillsController < ApplicationController
  before_filter :login_required, only:[:new]
  def index
    #.all calls db immediately
    if params[:search]
      #
      # search_active_skills(find_search_variables)
      search_hash = params[:search]
      zip   = search_hash[:location][:zip].blank?   ? "%%" : search_hash[:location][:zip]
      city  = search_hash[:location][:city].blank?  ? "%%" : search_hash[:location][:city]
      state = search_hash[:location][:state].blank? ? "%%" : search_hash[:location][:state]
      categories = search_hash[:categories].split(',').map{|x| "\'" + x + "\'"}.join(',')
      locations = Location.where("city LIKE ? AND state LIKE ? AND zip LIKE ?", city,state,zip)
      query = "SELECT * FROM skills
      JOIN locations on locations.id = skills.location_id
      JOIN skill_categories on skill_categories.skill_id = skills.id
      JOIN categories on skill_categories.category_id = categories.id
      WHERE locations.zip LIKE '#{zip}'
      AND locations.city LIKE '#{city}'
      AND locations.state LIKE '#{state}'
      AND is_active = 't'"
      unless categories.blank?
        query += " AND categories.id IN (#{categories})"
      end
      results = ActiveRecord::Base.connection.execute(query);
      skill_ids = results.map{|r| r["skill_id"]}
      @skills = Skill.includes(:categories,:location).find(skill_ids)
      respond_to do |format|
        format.js { render :partial =>  'refills/cards', :content_type => 'text/html', layout:false }
        format.html
      end
    else
      @skills = Skill.where(is_active: true).includes(:categories,:location)
      respond_to do |format|
        format.js { render :partial =>  'refills/cards', :content_type => 'text/html', layout:false }
        format.html
      end
    end
  end

  def show
    @skill = Skill.find(params[:id])
    if !@skill.is_active? && @skill.creator != current_user
      redirect_to root_path
    end
  end

  def new
    @categories = Category.order('name')
    @skill = Skill.new
    @path  = Path.new
    @paths = current_user.paths
    @skill.categories.build
    @skill.build_location
  end

  def create
    params[:skill].merge!({creator_id: current_user.id})
    category_ids = params[:skill]["category_ids"].split(',')
    params[:skill].merge!({category_ids: category_ids})
    @skill = Skill.new(skill_params)
    @skill.location_id = find_location
    if @skill.save
      redirect_to dashboard_path
    else
      # flash[:errors] = "#{@skill.errors.messages}"
      render 'new'
    end
  end

  def edit
    skill = Skill.find(params[:id])
    if current_user == skill.creator
      @skill = skill
      @paths = current_user.paths
      @path  = skill.path || skill.build_path
    else
      redirect_to root_path
    end
  end

  def update
    @skill = Skill.find(params['id'])
    category_ids = params[:skill]["category_ids"].split(',')
    params[:skill].merge!({category_ids: category_ids})
    if @skill.update_attributes(skill_params)
      @skill.location_id = find_location
      if @skill.save
       redirect_to @skill
      else
        render 'edit'
      end
    else
      render 'edit'
    end
  end

  def apprentices
    skill        = Skill.find(params[:id])
    @apprentices = skill.apprentices
  end

  def destroy
    skill = Skill.find(params['id'])
    skill.destroy()
    redirect_to dashboard_path
  end

  private

    def skill_params
      params.require(:skill).permit(:title,:subtitle,:full_description,:skill_level_id,:creator_id,:is_active,:path_id,category_ids:[],location_attributes:[:city,:state,:zip, :id])
    end

    def find_location
      params[:skill][:location_id].to_s.blank? ? Location.find_or_create_by(params[:skill][:location_attributes].symbolize_keys).id : params[:skill][:location_id]
    end


end
