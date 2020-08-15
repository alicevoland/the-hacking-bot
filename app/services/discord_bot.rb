class DiscordBot
  @@bot = nil

  # Returns: True if we had to wake up the bot, false otherwise
  def self.keep_alive
    if woke_up = @@bot.nil?

      @@bot = bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_BOT_TOKEN'],
                                                        client_id: ENV['DISCORD_CLIENT_ID'],
                                                        prefix: '$',
                                                        advanced_functionality: true

      list = CommandList.new bot

      list.add_command VerifyCommand.new
      list.add_command StatusCommand.new
      list.add_command MoodCommand.new
      list.add_command VisibilityCommand.new
      list.add_command MentionCommand.new

      list.add_help

      at_exit { bot.stop }
      bot.run :async
      puts 'STARTED THE HACKING BOT'
    end
    User.all.select do |user|
      user.discord? && user.check_expired_status
    end.each do |user|
      puts "Status of #{user.name} expired"
      @@bot.send_message(@@bot.users[user.discord_id].pm, "Bonjour #{user.name}
Ton statut s'est remis à la valeur par défaut : `work_in_progress`
Tu peux redéfinir ton statut en répondant `can_help` ou `need_help` à ce message
-- A bientôt sur : <https://the-hacking-bot.herokuapp.com>")
    end
    woke_up
  end

  def self.get_bot
    keep_alive
    @@bot
  end
end
