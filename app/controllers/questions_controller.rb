class QuestionsController < ApplicationController
  before_action :logged_in_user
  before_action :load_subjects, except: [:index]
  before_action :load_question, only: [:edit, :update, :destroy]

  def index
    @questions = current_user.questions.paginate page: params[:page],
      per_page: Settings.per_page
  end

  def new
    @question = Question.new
  end

  def edit
  end

  def create
    @question = Question.new question_params
    @question.user_id = current_user.id
    if @question.save
      flash[:success] = t "feature.questions.create_success"
      redirect_to questions_path
    else
      flash[:danger] = t "feature.questions.create_error"
      render :new
    end
  end

  def update
    if @question.update_attributes question_params
      flash[:success] = t "update_question_success"
      redirect_to questions_path
    else
      flash[:danger] = t "update_question_error"
      render :edit
    end
  end

  def destroy
    if @question.destroy
      flash[:success] = t "delete_question_success"
      redirect_to questions_path
    else
      flash[:notice] = t "delete_question_fail"
      redirect_to :back
    end
  end

  private
  def question_params
    params.require(:question).permit :content, :question_type, :subject_id,
      :state, answers_attributes: [:id, :content, :is_correct, :_destroy]
  end

  def load_subjects
    @subjects = Subject.all
  end

  def load_question
    @question = Question.find_by id: params[:id]
  end
end
