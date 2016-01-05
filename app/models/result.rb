class Result < ActiveRecord::Base
  serialize :content_answer, Array
  belongs_to :question
  belongs_to :answer
  belongs_to :exam
end
