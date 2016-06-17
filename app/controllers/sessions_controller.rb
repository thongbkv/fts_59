class SessionsController < ApplicationController
  def new
  end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      params[:session][:remember_me] == "1" ? remember(user) : forget(user)
      if session[:forwarding_url].present?
        redirect_to session[:forwarding_url]
        session.delete :forwarding_url
      else
        redirect_to root_url
      end
    else
      flash.now[:danger] = t "controller.message"
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
