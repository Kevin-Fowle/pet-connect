class ApplicationController < ActionController::Base
  include UserHelper
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session
  before_action :require_login


  private

  def require_login
    unless logged_in?
      flash[:error] = "You must be logged in to access this section"
      redirect_to new_session_url
    end
  end

  def organization_admin

  end

  def authorized?
    if !(@user.id == current_user.idea)
      session.destroy
      redirect_to '/'
    end
  end


end
