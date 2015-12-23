class CreateExams < ActiveRecord::Migration
  def change
    create_table :exams do |t|
      t.integer :time
      t.integer :mark
      t.string :status
      t.references :user, index: true, foreign_key: true
      t.references :category, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
