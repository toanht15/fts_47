class AddDefaultValueToTimeSpent < ActiveRecord::Migration
  def change
    change_column :exams, :spent_time, :interger, default: 0
  end
end
