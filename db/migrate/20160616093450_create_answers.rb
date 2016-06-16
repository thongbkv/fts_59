class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.string :content
      t.boolean :ís_correct
      t.references :question, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
