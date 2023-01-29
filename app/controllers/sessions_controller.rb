class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: session_params[:email].downcase)
    if user && user.authenticate(session_params[:password])
      session[:user_id] = user.id
      redirect_to tasks_path
    else
      flash.now[:alert] = 'Email or password is incorrect'
      render 'new', status: :unauthorized
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'Logged Out!'
    redirect_to root_path
  end

  private

  def session_params
    params.permit(:email, :password)
  end

  def redirect_if_logged_in
    redirect_to tasks_path if logged_in?
  end

end
