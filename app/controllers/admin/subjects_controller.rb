class Admin::SubjectsController < ApplicationController
  before_action :logged_in_user, :require_admin
  layout "admin"
  before_action :load_lesson, only: :show
  before_action :load_subject, only: [:edit, :update, :destroy]

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def show
    @lessons = @subject.lessons.order(created_at: :desc)
  end

  def new
    @subject = Subject.new
  end

  def edit
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "feature.subjects.create_success"
      redirect_to admin_subjects_path
    else
      render :new
    end
  end

  def update
    if @subject.update_attributes subject_params
      flash[:success] = t "feature.subjects.update_success"
      redirect_to admin_subjects_path
    else
      flash[:danger] = t "feature.subjects.update_error"
      render :edit
    end
  end

  def destroy
    if @subject.destroy
      flash[:success] = t "feature.subjects.delete_success"
    else
      flash[:danger] = t "feature.subjects.delete_error"
    end
    redirect_to admin_subjects_path
  end

  private
  def subject_params
    params.require(:subject).permit :name, :question_number, :duration
  end

  def load_lesson
    @subject = Subject.find_by id: params[:id]
  end

  def load_subject
    @subject = Subject.find_by id: params[:id]
  end
end
