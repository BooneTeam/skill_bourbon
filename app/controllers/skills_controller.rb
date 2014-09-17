class SkillsController < ApplicationController

  def index
    #.all calls db immediately
    if params[:search]
      search_hash = params[:search]
      zip   = search_hash[:zip].blank?   ? "%%" : search_hash[:zip]
      city  = search_hash[:city].blank?  ? "%%" : search_hash[:city]
      state = search_hash[:state].blank? ? "%%" : search_hash[:state]
      categories = search_hash[:categories].split(',').map{|x| "\'" + x + "\'"}.join(',')
      locations = Location.where("city LIKE ? AND state LIKE ? AND zip LIKE ?", city,state,zip)
      query = "SELECT * FROM skills
      JOIN locations  on locations.id = skills.location_id
      JOIN skill_categories on skill_categories.skill_id = skills.id
      JOIN categories on skill_categories.skill_id = categories.id
      WHERE locations.zip LIKE '#{zip}'
      AND locations.city LIKE '#{city}'
      AND locations.state LIKE '#{state}'"
      unless categories.blank?
        query += "AND categories.name IN (#{categories})"
      end
      binding.pry
      results = ActiveRecord::Base.connection.execute(query);
      skill_ids = results.map{|r| r["id"]}
      @skills = Skill.find(skill_ids)
      render :partial =>  'refills/cards', :content_type => 'text/html'
    else
      @skills = Skill.all
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
    binding.pry
    skill = Skill.new(skill_params)
    binding.pry
    if skill.save
      redirect_to dashboard_path
    else
      # binding.pry
      flash[:error] = "An error message for the user"
      redirect_to :back
    end
  end

  def update

  end

  def destroy

  end

  private

    def skill_params
      params.require(:skill).permit(:title,:subtitle,:full_description,:creator_level,:creator_id,:category_ids, location_attributes:[:city,:state,:zip])
    end

end
