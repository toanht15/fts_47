class Exam < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  has_many :results, dependent: :destroy
  has_many :questions, through: :results

  after_create :send_email_delay_exam

  scope :order_desc, -> {order created_at: :desc}

  enum status: [:start, :uncheck, :checked, :testing]

  accepts_nested_attributes_for :results, allow_destroy: true

  validates :user_id, presence: true
  validates :category_id, presence: true

  before_create :generate_questions
  after_update :update_mark, if: :checked?

  def remain_time
    Settings.exam.duration * Settings.exam.minute - spent_time.to_i
  end

  def time_spent
    spent_time.to_i + (Time.zone.now - updated_at).to_i
  end

  def calculate_mark
    self.results.correct.count
  end

  def send_email_delay_exam
    ExamMailer.notify_delay(self).deliver_now
  end

  handle_asynchronously :send_email_delay_exam, run_at: Proc.new {Settings.email.time}

  private
  def generate_questions
    self.questions = self.category.questions.order("RANDOM()").
      limit(Settings.exam.question_number).each do |question|
        results.build question_id: question.id
      end
  end

  def update_mark
    self.update_column :mark, self.calculate_mark
  end
end
