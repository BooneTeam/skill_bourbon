class ApplicationController < ActionController::Base
  $is_beta = true
  # add_flash_types :error
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  # redirect back to page where user came from after logging in.
  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'devise/sessions', :only_path => false, :protocol => 'http')
    sign_up_url = url_for(:action => 'new', :controller => 'users/registrations', :only_path => false, :protocol => 'http')
    if request.referer == sign_in_url || request.referer == sign_up_url
      super
    else
      stored_location_for(resource) || request.referer || root_path
    end
  end

  def login_required
    if ($is_beta && current_user.username.include?("test_beta"))
      session[:return_to_url] = request.url
    elsif ($is_beta && !current_user.username.include?("test_beta"))
      redirect_to what_is_path
    elsif current_user && !$is_beta
        session[:return_to_url] = request.url
    else
      redirect_to new_user_registration_path
    end
  end

end
