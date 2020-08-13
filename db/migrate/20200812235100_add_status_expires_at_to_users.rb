class AddStatusExpiresAtToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :status_expires_at, :datetime
  end
end
