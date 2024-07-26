class InterviewMailer < ApplicationMailer
  default from: 'your_email@example.com'

  def interview_scheduled(interview)
    @interview = interview
    @candidate = Candidate.find(@interview.candidate_id)
    @employee = User.find(@interview.employee_id)

    mail(to: @candidate.email, subject: 'Your Interview is Scheduled')
    mail(to: @employee.email, subject: 'Interview Scheduled with Candidate')
  end
  
  def interview_canceled(interview)
    @interview = interview
    @candidate = Candidate.find(@interview.candidate_id)
    @employee = User.find(@interview.employee_id)

    mail(to: @candidate.email, subject: 'Your Interview has been Canceled')
    mail(to: @employee.email, subject: 'Interview with Candidate has been Canceled')
  end
end
