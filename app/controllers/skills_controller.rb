class SkillsController < ApplicationController

  def index
    #.all calls db immediately
    if params[:search]
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
      @skills = Skill.find(skill_ids)
      render :partial =>  'refills/cards', :content_type => 'text/html'
    else
      @skills = Skill.where(is_active: true)
    end
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    if current_user
      @categories = Category.order('name')
      @skill = Skill.new
      @skill.categories.build
      @skill.build_location
    else
      redirect_to new_user_registration_path
    end
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
    @skill = Skill.find(params[:id])
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

  def destroy

  end

  private

    def skill_params
      params.require(:skill).permit(:title,:subtitle,:full_description,:skill_level_id,:creator_id,:is_active,category_ids:[],location_attributes:[:city,:state,:zip, :id])
    end

    def find_location
      params[:skill][:location_id].to_s.blank? ? Location.find_or_create_by(params[:skill][:location_attributes].symbolize_keys).id : params[:skill][:location_id]
    end


end
