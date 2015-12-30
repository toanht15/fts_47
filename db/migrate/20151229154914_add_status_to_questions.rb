class AddStatusToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :status, :integer, default: Question.statuses[:waitting]
  end
end
