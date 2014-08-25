class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def teaching
    @skills = current_user.user_skills.earning
  end

  def learning
    @skills = current_user.user_skills.learning
  end

end
