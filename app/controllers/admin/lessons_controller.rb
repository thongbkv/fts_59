class Admin::LessonsController < ApplicationController
  before_action :logged_in_user, :require_admin
  layout "admin"
  before_action :load_subjects, only: :index
  before_action :load_lesson, only: [:show, :update]

  def index
  end

  def show
    @results = @lesson.results
  end

  def update
    @lesson.status = :checked if params[:commit] == Settings.finish
    if @lesson.update_attributes lesson_params
      flash[:success] = t ".update_lesson_success"
    else
      flash[:danger] =  t ".update_lesson_fail"
    end
    redirect_to admin_lessons_path
  end

  private
  def load_subjects
    @subjects = Subject.all
  end

  def load_lesson
    @lesson = Lesson.find_by id: params[:id]
  end

  def lesson_params
    params.require(:lesson).permit :status
  end
end
