class Result < ActiveRecord::Base
  belongs_to :question
  belongs_to :lesson
end
