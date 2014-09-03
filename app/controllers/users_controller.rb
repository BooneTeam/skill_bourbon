class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def teaching
    @skills = current_user.created_skills
  end

  def learning
    @skills = current_user.apprenticeships
  end

end
