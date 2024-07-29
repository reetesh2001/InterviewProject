class AddEndInterviewTimeToInterviews < ActiveRecord::Migration[7.1]
  def change
    add_column :interviews, :end_interview_time, :datetime
  end
end
