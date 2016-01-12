class HardWorker
  include Sidekiq::Worker
  def perform exam_id
    exam = Exam.find exam_id
    UserMailer.result_exam(exam).deliver_now
  end
end
