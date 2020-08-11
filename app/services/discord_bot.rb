class DiscordBot
  @@discord_bot = nil

  def self.run
    return false unless @@discord_bot.nil?

    @@discord_bot = Discordrb::Commands::CommandBot.new token: ENV['DISCORD_BOT_TOKEN'],
                                                        client_id: ENV['DISCORD_CLIENT_ID'],
                                                        prefix: '$',
                                                        advanced_functionality: true
    bot = @@discord_bot

    bot.command :verify do |event, email, token|
      # Can't find user
      unless (user = User.find_by(email: email))
        event.respond "Pas d'utilisateur avec cet email : #{email}"
        event.respond 'Merci de recommencer : <https://the-hacking-bot.herokuapp.com/discord_verify>'
        return
      end

      # Account already linked
      if user.discord?
        event.respond 'Ton compte est déjà lié : <https://the-hacking-bot.herokuapp.com/profile>'
        return
      end

      # Token is not right
      unless BCrypt::Password.new(user.discord_verify_digest).is_password?(token)
        event.respond 'Le token ne semble pas valide'
        event.respond 'Merci de recommencer : <https://the-hacking-bot.herokuapp.com/discord_verify>'
        return
      end

      # Update user does not work
      unless user.update(discord_id: event.user.id, discord_username: event.user.username)
        event.respond 'Désolé, il y a eu un problème inconnu (êtes vous déjà inscrit avec le même Discord ID ?)'
        event.respond user.errors.full_messages.map(&:to_s).join "\n"
        return
     end

      # OK, thank user
      event.respond "Merci #{event.user.username}, tu as bien lié ton compte <https://the-hacking-bot.herokuapp.com/profile>"
      # user.work_in_progress!
    end

    bot.command :status do |event, status|
      user = User.find_by(discord_id: event.user.id)
      unless user
        event.respond 'Utilisateur non trouvé, as-tu lié ton compte ? <https://the-hacking-bot.herokuapp.com/discord_verify>'
        return
      end
      unless status
        event.respond "Ton status actuel est #{user.status}"
        return
      end
      if 'can_help' == status.downcase
        user.can_help!
      elsif 'need_help' == status.downcase
        user.need_help!
      elsif 'work_in_progress' == status.downcase
        user.work_in_progress!
      else
        event.respond "Je ne comprends pas le statut #{status}. Les possibilités sont `can_help` OU `need_help` OU `work_in_progress`"
        return
      end
      event.respond "Merci ! Ton statut est maintenant #{user.status}"
    end

    bot.command :visible do |event, visible|
      user = User.find_by(discord_id: event.user.id)
      unless user
        event.respond 'Utilisateur non trouvé, as-tu lié ton compte ? <https://the-hacking-bot.herokuapp.com/discord_verify>'
        return
      end
      unless visible
        event.respond "Ton visibilité actuelle est #{user.visible}"
        return
      end
      user.update(visible: ('true' == visible.downcase))
      event.respond "Merci ! Ta visibilité est maintenant #{user.visible}"
    end

    bot.command :mood do |event, mood|
      user = User.find_by(discord_id: event.user.id)
      unless user
        event.respond 'Utilisateur non trouvé, as-tu lié ton compte ? <https://the-hacking-bot.herokuapp.com/discord_verify>'
        return
      end
      unless mood
        event.respond "Ton mood actuel est #{user.mood}"
        return
      end
      user.update(mood: mood)
      event.respond "Merci ! Ton mood est maintenant #{user.mood}"
    end

    bot.command :help do |event|
      event.respond "Liste des commandes (The Hacking Bot):
------------------------------------------------------------------------
`$help               ` > Ce message
`$verifiy EMAIL TOKEN` > Vérifier son compte Discord avec <https://the-hacking-bot.herokuapp.com/discord_verify>
`$status STATUS      ` > Modifier mon statut, STATUS=`can_help` OU `need_help` OU `work_in_progress`
`$mood \"mon problème\"` > Modifié mon humeur, sera affiché avec le status si je choisis visible. Les \" \" sont obligatoires (sinon seulement un mot)
`$visible TRUE|FALSE ` > Je veux que mon statut et mood soit visible ou invisible sur <https://the-hacking-bot.herokuapp.com/users"
      event.respond "Plus d'information sur <https://the-hacking-bot.herokuapp.com>"
    end

    at_exit { bot.stop }
    bot.run :async
    true
  end
end
