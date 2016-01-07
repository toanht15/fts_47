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

  def status_exam exam
    case exam.status
    when Settings.exam.status.start
      content_tag :span, t("exam.status.start"), class: "label label-primary"
    when Settings.exam.status.checked
      content_tag :span, t("exam.status.checked"), class: "label label-success"
    when Settings.exam.status.uncheck
      content_tag :span, t("exam.status.uncheck"), class: "label label-info"
    when Settings.exam.status.testing
      content_tag :span, t("exam.status.testing"), class: "label label-warning"
    end
  end
end
