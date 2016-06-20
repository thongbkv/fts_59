class Admin::LessonsController < ApplicationController
  before_action :logged_in_user, :require_admin
  before_action :load_subjects, only: :index

  def index
  end

  private
  def load_subjects
    @subjects = Subject.all
  end
end
