class BaseCommand
  def keywords
    %i[keyword alias]
  end

  def perform(_bot, _event, _args)
    puts 'WARNING: BaseCommand#perform not overridden'
  end

  def perform_complete(bot, event, args)
    perform bot, event, args
    footer event
  end

  def register bot
    bot.command keywords do |event, *args|
      perform_complete bot, event, args
    end
    post_register(bot)
  end

  def post_register(bot); end

  def check_user_by_discord_id(event)
    user = User.find_by(discord_id: event.user.id)
    unless user
      event.respond 'Utilisateur non trouvé, as-tu lié ton compte ? <https://the-hacking-bot.herokuapp.com/discord_verify>'
    end
    user
  end

  def check_user_by_email(event, email)
    user = User.find_by(email: email)
    unless user
      event.respond "Pas d'utilisateur avec cet email : #{email}"
      event.respond 'Merci de recommencer : <https://the-hacking-bot.herokuapp.com/discord_verify>'
    end
    user
  end

  def check_fixed_size_args(event, args, expected)
    unless args.size == expected.size
      event.respond "Merci de vérifier les arguments: #{expected.join(' ')}"
      return false
    end
    true
  end

  def footer event
    event.respond '-- A bientôt sur : <https://the-hacking-bot.herokuapp.com>'
  end

  def help_message
    [{ command: keywords.first, args: '', descriptiont: '' }]
  end
end
