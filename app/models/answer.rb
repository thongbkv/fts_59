class Answer < ActiveRecord::Base
  belongs_to :question

  QUERY = "id IN (SELECT answers.id FROM answers INEER JOIN results
    ON results.answer_id = answers.id
    WHERE answers.is_correct = ? AND results.lesson_id = ?)"

  scope :is_correct_answers, ->(lesson_id){where QUERY, true, lesson_id}
end
