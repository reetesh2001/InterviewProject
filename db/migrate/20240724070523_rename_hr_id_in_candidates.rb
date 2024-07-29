class RenameHr_idInCandidate < ActiveRecord::Migration[7.1]
  def change
    rename_column :candidates, :"hr_id", :user_id
  end
end
