class Subject < ActiveRecord::Base
  has_many :lessons
  has_many :questions

  validates :name, presence: true, length: {maximum: 100}
  validates :question_number, presence: true,
    numericality:{only_integer: true, greater_than: 1}
  validates :duration, presence: true,
    numericality:{only_integer: true, greater_than: 1}
end
