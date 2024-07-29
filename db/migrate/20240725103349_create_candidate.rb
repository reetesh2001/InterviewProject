class CreateCandidate < ActiveRecord::Migration[7.1]
  def change
    create_table :candidates do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :role
      t.string :qualification
      t.string :college
      t.string :experience
      t.string :company
      t.string :user_id
      t.timestamps
    end
  end
end
