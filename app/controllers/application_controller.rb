class ApplicationController < ActionController::Base
  # add_flash_types :error
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def after_sign_in_path_for(resource)

    sign_in_url = url_for(:action => 'new', :controller => 'devise/sessions', :only_path => false, :protocol => 'http')
    sign_up_url = url_for(:action => 'new', :controller => 'users/registrations', :only_path => false, :protocol => 'http')
    if request.referer == sign_in_url || request.referer == sign_up_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

end
