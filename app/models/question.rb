class Question < ActiveRecord::Base
  belongs_to :subject
  belongs_to :user

  has_many :answers
  has_many :results

  accepts_nested_attributes_for :answers,
    reject_if: proc {|attributes| attributes[:content].blank?},
    allow_destroy: true

  enum question_type: [:single, :multiple]
end
