class Question < ActiveRecord::Base
  belongs_to :category
  has_many :answers, dependent: :destroy

  enum question_type: [:single_choice, :multiple_choices, :text]

  accepts_nested_attributes_for :answers, allow_destroy: true
  validates :content, presence: true
  validate :check_question_type

  private
  def correct_answer
    answers.select{|answer| answer.correct}
  end

  def check_question_type
    if correct_answer.blank?
      errors.add :base, I18n.t("question.error.blank")
    else
      case question_type
      when Settings.question.types.single
        errors.add :base, I18n.t("question.error.corect") if
          correct_answer.count > Settings.question.num_correct
      when Settings.question.types.text
        errors.add :base, I18n.t("question.error.corect") if
          correct_answer.count > Settings.question.num_correct
      end
    end
  end
end
