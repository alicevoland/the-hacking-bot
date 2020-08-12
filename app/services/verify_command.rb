class VerifyCommand < BaseCommand
  def keywords
    %i[verify vérifier]
  end

  def perform _bot, event, args
    return unless check_fixed_size_args(event, args, %i[email token])

    email, token = args
    return unless user = check_user_by_email(event, email)
    return unless check_not_already_verified event, user
    return unless check_token event, user, token
    return unless check_update event, user

    event.respond "Merci #{event.user.username}, tu as bien lié ton compte <https://the-hacking-bot.herokuapp.com/profile>"
  end

  def check_not_already_verified(event, user)
    if user.discord?
      event.respond 'Ton compte est déjà lié : <https://the-hacking-bot.herokuapp.com/profile>'
      return false
    end
    true
  end

  def check_token(event, user, token)
    unless BCrypt::Password.new(user.discord_verify_digest).is_password?(token)
      event.respond 'Le token ne semble pas valide'
      event.respond 'Merci de recommencer : <https://the-hacking-bot.herokuapp.com/discord_verify>'
      return false
    end
    true
  end

  def check_update(event, user)
    unless user.update(discord_id: event.user.id, discord_username: event.user.username)
      event.respond 'Désolé, il y a eu un problème inconnu (êtes vous déjà inscrit avec le même Discord ID ?)'
      event.respond user.errors.full_messages.map(&:to_s).join "\n"
      return false
    end
    true
  end

  def help_message
    [{ command: keywords.first, args: 'EMAIL TOKEN', description: 'Pour lier le compte Discord à The Hacking Bot' }]
end
end
