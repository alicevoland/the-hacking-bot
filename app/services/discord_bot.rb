class DiscordBot
  @@bot = nil

  # Returns: True if we had to wake up the bot, false otherwise
  def self.keep_alive
    return false unless @@bot.nil?

    @@bot = bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_BOT_TOKEN'],
                                                      client_id: ENV['DISCORD_CLIENT_ID'],
                                                      prefix: '$',
                                                      advanced_functionality: true

    list = CommandList.new bot

    list.add_command VerifyCommand.new
    list.add_command StatusCommand.new
    list.add_command MoodCommand.new
    list.add_command VisibilityCommand.new

    at_exit { bot.stop }
    bot.run :async
    puts 'STARTED THE HACKING BOT'
    true
  end

  def self.get_bot
    keep_alive
    @@bot
  end
end
