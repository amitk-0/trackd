class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def user_not_authorized
    flash[:error] = 'Information you requested, either does not exist or is not authorized for access.'
    redirect_to root_path
  end

  def authenticate_user!
    unless current_user
      redirect_to login_path, alert: 'Please log in to continue'
    end
  end

end
