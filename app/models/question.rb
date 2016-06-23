class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :answers
  has_many :results

  validates :content, presence: true, length: {maximum: 200}

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  enum question_type: [:single, :multiple]
  enum state: [:wating, :unapprove, :approve]

  scope :suggest_questions_user, ->(user_id){where.not user_id: user_id}
  scope :question_random, ->{where state: 2}

  def check_answer_user_is_correct? result
    result.answer_id == answers.where(is_correct: true)
  end
end
