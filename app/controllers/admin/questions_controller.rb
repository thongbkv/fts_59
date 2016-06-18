class Admin::QuestionsController < ApplicationController
  before_action :logged_in_user, :require_admin
  before_action :load_subjects, only: :new
  layout "admin"

  def index
    @questions = Question.paginate page: params[:page]
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      flash[:success] = t "feature.questions.create_success"
      redirect_to new_admin_question_path
    else
      flash[:danger] = t "feature.questions.create_error"
      render :new
    end
  end

  private
  def question_params
    params.require(:question).permit :content, :question_type, :state, :subject_id,
      :user_id, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_subjects
    @subjects = Subject.all
  end
end
