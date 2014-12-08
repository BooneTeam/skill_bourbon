class SkillsController < ApplicationController

  include SearchHelper

  before_filter :login_required, only:[:new]

  def index
    skills  = search_for(Skill,params).active.archived(false).includes(:location,:categories)
    @skills = skills.ordered_by_date.paginate(:page => params[:page])
    respond_to do |format|
      format.js { render :partial =>  'refills/cards', :content_type => 'text/html', layout:false }
      format.html
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
      @errors = @skill.errors.full_messages
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
    params[:skill]["category_ids"] ||= ''
    @skill = Skill.find(params['id'])
    category_ids = params[:skill]["category_ids"].split(',')
    if !category_ids.empty?
      params[:skill].merge!({category_ids: category_ids})
    end
    if @skill.update_attributes(skill_params)
      if params[:skill][:location_id]
        @skill.location_id = find_location
      end
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
      params.require(:skill).permit(:title,:subtitle,:full_description,:price,:skill_level_id,:creator_id,:is_active,:path_id,:archived,category_ids:[],location_attributes:[:city,:state,:zip, :id])
    end

    def find_location
      params[:skill][:location_id].to_s.blank? ? Location.find_or_create_by(params[:skill][:location_attributes].symbolize_keys).id : params[:skill][:location_id]
    end


end
