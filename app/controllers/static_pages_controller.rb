class StaticPagesController < ApplicationController

  def home
    # if current_user
      # redirect_to dashboard_path
    # end
  end

  def coming_soon
    @disable_nav    = true
    @disable_footer = true
  end

  def what_is

  end

  def faq

  end

  def contact

  end

end
