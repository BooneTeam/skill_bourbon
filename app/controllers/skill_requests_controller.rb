class SkillRequestsController < ApplicationController

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
