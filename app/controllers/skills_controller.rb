class SkillsController < ApplicationController

  include SearchHelper

  before_filter :login_required, only:[:new]
  def index
    if params[:search]
      @skills = search_for(Skill, params, {ands: [{string: "is_active = ?",q: true }] }).paginate(:page => params[:page])
      respond_to do |format|
        format.js { render :partial =>  'refills/cards', :content_type => 'text/html', layout:false }
        format.html
      end
    else
      skills  = Skill.where(is_active: true).includes(:categories,:location)
      @skills = skills.paginate(:page => params[:page])
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
