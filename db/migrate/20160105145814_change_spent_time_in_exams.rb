class ChangeSpentTimeInExams < ActiveRecord::Migration
  def change
    change_column :exams, :spent_time, :integer
  end
end
