module ExamsHelper

  def check_correct_answer result
    if result.question.text?
      result.content_answer[0] == result.question.answers.correct_answer[0].content
    else
      (result.question.answers.correct_answer.ids.map{|id| id.to_s} -
        result.content_answer).empty? && result.question.answers.correct_answer.size ==
        result.content_answer.size
    end
  end
end
