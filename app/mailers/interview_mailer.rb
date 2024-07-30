class InterviewMailer < ApplicationMailer
  default from: 'your_email@example.com'

  def candidate_email(interview)
    @interview = interview
    @candidate = Candidate.find(@interview.candidate_id)
    mail(to: @candidate.email, subject: 'Your Interview is Scheduled')
  end
  
  def employee_email(interview)
    @interview = interview
    @employee = User.find(@interview.employee_id)

    mail(to: @employee.email, subject: 'Interview with Candidate has been scheduled')
  end

end
