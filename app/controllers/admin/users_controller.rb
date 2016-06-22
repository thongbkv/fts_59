class Admin::UsersController < ApplicationController
  before_action :logged_in_user, :require_admin
  layout "admin"

  def index
    @questions = Question.suggest_questions_user current_user.id
  end
end
