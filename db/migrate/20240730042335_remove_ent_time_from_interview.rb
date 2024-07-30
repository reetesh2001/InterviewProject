class RemoveEntTimeFromInterview < ActiveRecord::Migration[7.1]
  def change
    remove_column :interviews, :end_interview_time
  end
end
