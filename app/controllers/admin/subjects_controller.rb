class Admin::SubjectsController < Admin::BasesController
  before_action :logged_in_user, :require_admin
  before_action :load_lesson, only: :show

  def index
    @subjects = Subject.paginate page: params[:page]
  end

  def show
    @lessons = @subject.lessons
  end

  def new
    @subject = Subject.new
  end

  def create
    @subject = Subject.new subject_params
    if @subject.save
      flash[:success] = t "feature.subjects.create_success"
      redirect_to admin_users_path
    else
      render :new
    end
  end

  private
  def subject_params
    params.require(:subject).permit :name, :question_number, :duration
  end

  def load_lesson
    @subject = Subject.find_by id: params[:id]
  end
end
