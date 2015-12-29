class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  accepts_nested_attributes_for :results, allow_destroy: true

  validates :user_id, presence: true
  validates :category_id, presence: true

  before_create :generate_questions

  private
  def generate_questions
    self.questions = self.category.questions.order("RANDOM()").
      limit Settings.exam.question_number
  end
end
