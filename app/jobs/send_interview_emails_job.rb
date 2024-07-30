class SendInterviewEmailsJob < ApplicationJob
  queue_as :default

  def perform(interview)
    InterviewMailer.candidate_email(interview).deliver_later
    InterviewMailer.employee_email(interview).deliver_later
  end
end
