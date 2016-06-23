class Lesson < ActiveRecord::Base
  belongs_to :user
  belongs_to :subject
  has_many :results
  has_many :questions, through: :results

  validate :lesson_min, on: :create

  enum status: [:start, :testing, :unchecked, :checked]

  before_create :create_results

  accepts_nested_attributes_for :results

  def change_status_lesson
    if self.start?
      self.status = :testing
      self.save
    end
  end

  def get_point lesson_id
    @point = Answer.is_correct_answers(lesson_id).count
    @question_number = Lesson.find_by(id: lesson_id).subject.question_number
    return @point, @question_number
  end

  private
  def create_results
    self.questions << self.subject.questions.question_random.order("RANDOM()")
      .limit(self.subject.question_number)
  end

  def lesson_min
    if self.subject.questions.size < self.subject.question_number
      errors.add(:base, "oke")
    end
  end
end
