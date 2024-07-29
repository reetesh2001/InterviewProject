class DropCandidate < ActiveRecord::Migration[7.1]
  def change
    drop_table :candidates
  end
end
