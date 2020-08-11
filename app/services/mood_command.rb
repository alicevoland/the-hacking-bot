class MoodCommand < BaseCommand
  def keywords
    %i[mood humeur]
  end

  def perform _bot, event, args
    return unless user = check_user_by_discord_id(event)

    if args.empty?
      event.respond "Ton humeur actuelle est : #{user.mood}"
      return
    end

    mood = args.join ' '

    user.update(mood: mood)
    event.respond "Merci ! Ton humeur est maintenant #{user.mood}"
    footer event
  end

  def help_message
    [{ command: keywords.first, args: 'ton humeur, une petite phrase', description: 'Bloqué sur :&#!!?' }]
end
end
