class AddFieldNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string
    add_column :users, :role, :string
    add_column :users, :phone, :string
  end
end
