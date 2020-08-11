class AddDiscordColsToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :discord_id, :bigint
    add_column :users, :discord_username, :string
    add_column :users, :discord_verify_token, :string

    add_index :users, :discord_verify_token, unique: true
  end
end
