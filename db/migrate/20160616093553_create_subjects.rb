class CreateSubjects < ActiveRecord::Migration
  def change
    create_table :subjects do |t|
      t.string :name
      t.integer :duration
      t.integer :question_number

      t.timestamps null: false
    end
  end
end
