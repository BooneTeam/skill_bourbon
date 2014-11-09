class PathsController < ApplicationController

  def index

  end


  def new
    @path  = Path.new
    @paths = current_user.paths
  end

  def edit

  end

  def show
    @path = Path.find(params[:id])
  end

  def update

  end

  def create
    @path = Path.new(path_params)
    @path.user = current_user
    if @path.save!
      @paths = current_user.paths
      respond_to do |format|
        format.html
        format.json {render json: @path}
      end
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
