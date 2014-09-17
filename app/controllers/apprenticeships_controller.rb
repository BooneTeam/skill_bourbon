class ApprenticeshipsController < ApplicationController

  def index

  end

  def new

  end

  def create
    apprenticeship = Apprenticeship.new(apprenticeship_params)
    binding.pry
    if apprenticeship.save
      redirect_to dashboard_path
    else
      redirect_to :back
    end
  end

  def edit

  end

  def destroy

  end

    private

    def apprenticeship_params
      params.require(:apprenticeship).permit(:request_description,:apprentice_level,:date_scheduled)
    end

end
