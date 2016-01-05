class ChangeStatusTypeInExams < ActiveRecord::Migration
  def change
    change_column :exams, :status, :integer
  end
end
