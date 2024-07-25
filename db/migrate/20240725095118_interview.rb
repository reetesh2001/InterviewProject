class Interview < ActiveRecord::Migration[7.1]
  def change
    drop_table :interviews
  end
end
