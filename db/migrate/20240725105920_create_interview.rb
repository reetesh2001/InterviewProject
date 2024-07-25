class CreateInterview < ActiveRecord::Migration[7.1]
  def change
    create_table :interviews do |t|
      t.string :status
      t.string :feedback
      t.integer :round
      t.datetime :interview_time
      t.integer :user_id
      t.integer :candidate_id
      t.integer :employee_id
      t.timestamps
    end
  end
end
