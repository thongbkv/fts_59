# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

User.create name: "admin", email: "admin@framgia.com", password: "123456",
  password_confirmation: "123456", is_admin: true
User.create name: "user1", email: "user1@framgia.com", password: "123456",
  password_confirmation: "123456", is_admin: false

5.times do |n|
  Subject.create name: "Subject-#{n+1}", duration: 30, question_number: 10
end

30.times do |n|

  content  = Faker::Lorem.sentence(3, false, 4)
  subject_id = ((n % 5).ceil + 1)

  Question.create(content:  content,
    user_id: 1,
    subject_id: subject_id,
    state: 1,
    question_type: 0)

  3.times do |o|
    content  = Faker::Lorem.sentence(3, false, 4)
    Answer.create(content:  content,
      question_id: (n+1) ,
      is_correct: false)
  end

  Answer.create(content:  content,
    question_id: (n+1) ,
    is_correct: true)

end

30.times do |n|

  content  = Faker::Lorem.sentence(3, false, 4)
  subject_id = ((n % 5).ceil + 1)

  Question.create(content:  content,
    user_id: 1,
    subject_id: subject_id,
    state: 1,
    question_type: 1)

  4.times do |o|
    content  = Faker::Lorem.sentence(3, false, 4)
    Answer.create(content:  content,
      question_id: (n+51) ,
      is_correct: [true, false].sample)
  end
end
