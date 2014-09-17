class SkillRequestsController < ApplicationController

  def new
    @categories = Category.order('name')
    @skill_request = SkillRequest.new
  end

  def create
    params[:skill_request].merge!({user_id: current_user.id, filled:false})
    skill_request = SkillRequest.new(skill_request_params)
    binding.pry
    if skill_request.save
      redirect_to dashboard_path
    else
      flash[:error] = "An error message for the user"
      redirect_to :back
    end
  end

  private

    def skill_request_params
      params.require(:skill_request).permit(:title,:subtitle,:full_description,:user_id,:filled,:category_ids, location_attributes:[:city,:state,:zip])
    end
end
