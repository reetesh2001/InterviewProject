class Interview < ApplicationRecord
  belongs_to :user
  belongs_to :candidate
  validates :interview_time, presence: true
  enum round: { L1: 0, L2: 1, HR: 2 }
end
