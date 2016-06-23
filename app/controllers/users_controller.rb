class UsersController < ApplicationController
  before_action :load_user, only: [:show, :edit, :update]

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

  def edit
  end

  def update
    if @user.update_attributes user_params
      flash[:success] = t "user.update_success"
      redirect_to @user
    else
      flash[:danger] = t "user.update_error"
      render :edit
    end
  end

  private
  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def load_user
    @user = User.find_by id: params[:id]
  end
end
