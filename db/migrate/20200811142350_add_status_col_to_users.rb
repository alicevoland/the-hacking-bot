class AddStatusColToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status, :integer, default: 0
    add_column :users, :mood, :string, default: ''
    add_column :users, :visible, :boolean, default: false
  end
end
