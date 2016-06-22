class Admin::QuestionsController < ApplicationController
  before_action :logged_in_user, :require_admin
  before_action :load_subjects, only: [:new, :edit]
  before_action :load_question, only: [:edit, :update, :destroy]
  layout "admin"

  def index
    @questions = current_user.questions.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @question = Question.new
  end

  def create
    @question = Question.new question_params
    @question.user = current_user
    if @question.save
      flash[:success] = t "feature.questions.create_success"
      redirect_to admin_questions_path
    else
      flash[:danger] = t "feature.questions.create_error"
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "update_question_success"
      redirect_to admin_questions_path
    else
      flash[:danger] = t "update_question_fail"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "delete_question_success"
    else
      flash[:danger] = t "delete_question_fail"
    end
    redirect_to admin_questions_path
  end

  private
  def question_params
    params.require(:question).permit :content, :question_type, :state, :subject_id,
     answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_subjects
    @subjects = Subject.all
  end

  def load_question
    @question = Question.find_by id: params[:id]
  end
end

