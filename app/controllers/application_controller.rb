class ApplicationController < ActionController::Base
  include SessionsHelper

  protect_from_forgery with: :exception

  private
  def require_admin
    if current_user.is_admin?
      flash[:success] = t "shared.isadmin"
    else
      flash[:danger] = t "admin.static_pages.login_error"
      redirect_to root_path
    end
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = t "static_pages.login_error"
      redirect_to login_path
    end
  end
end
