class StaticPagesController < ApplicationController

  def home
    if current_user
      redirect_to dashboard_path
    end
  end

  def what_is

  end

  def faq

  end

  def contact

  end

end
