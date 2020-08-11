class AddDiscordColsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :discord_id, :bigint
    add_column :users, :discord_username, :string
    add_column :users, :discord_verify_digest, :string

    add_index :users, :discord_id, unique: true
  end
end
