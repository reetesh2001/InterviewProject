class Interview < ApplicationRecord
  belongs_to :user
  belongs_to :candidate
  after_create :send_interview_emails

  private

  def send_interview_emails
    SendInterviewEmailsJob.perform_later(self)
  end
end
