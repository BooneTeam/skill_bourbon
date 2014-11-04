class PathsController < ApplicationController

  def index

  end

  def new
    @path = Path.new
  end

  def edit

  end

  def update

  end

  def create
    path = Path.new(path_params)
    path.user = current_user
    if path.save!
      redirect_to :back
    else
      redirect_to :back
    end
  end

  def destroy

  end

  def path_params
    params.require('path').permit(:name,:description)
  end
end
