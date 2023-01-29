class ApplicationController < ActionController::Base
  include Pundit::Authorization
  helper_method :current_user
  helper_method :logged_in?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

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
    redirect_to login_path, alert: 'Please log in to continue' unless current_user
  end

  def authenticate_admin!
    redirect_to root_path, alert: 'Please log in as admin to continue' unless current_user.is_admin
  end

  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : 'asc'
  end

end
