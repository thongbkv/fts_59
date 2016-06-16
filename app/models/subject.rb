class Subject < ActiveRecord::Base
  has_many :lessons
  has_many :questions
end
