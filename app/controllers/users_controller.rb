class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new user_params
    if @user.save
      flash[:success] = t "user.create_user_success"
      if current_user.is_admin?
        redirect_to admin_lessons_path
      elsif
        redirect_to root_url
      end
    else
      render :new
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end
end
