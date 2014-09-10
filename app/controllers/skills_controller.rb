class SkillsController < ApplicationController

  def index
    #.all calls db immediately
    @skills = Skill.all
  end

  def show
    @skill = Skill.find(params[:id])
  end

  def new
    if current_user
      @skill = Skill.new
    else
      redirect_to new_user_registration_path
    end
  end

  def create

  end

  def update

  end

  def destroy

  end

  private

    # def skill_params
    #   params.require(:skill).permit(:apprentice)
    # end

end
