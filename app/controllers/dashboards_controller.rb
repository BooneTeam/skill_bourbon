class DashboardsController < ApplicationController

  def show
    @learning_skills = current_user.user_skills.learning
    @earning_skills = current_user.user_skills.earning
  end

end
