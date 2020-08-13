class StatusCommand < BaseCommand
  def keywords
    %i[status statut set s]
  end

  def perform(_bot, event, args)
    return unless user = check_user_by_discord_id(event)

    if args.empty?
      event.respond "Ton status actuel est #{user.status}"
      return
    end

    status = args.join('_').downcase

    if user.set_status(status)
      event.respond "Merci ! Ton statut est maintenant #{user.status}"
    else
      event.respond "Je ne comprends pas le statut #{status}. Les possibilités sont `can_help` OU `need_help` OU `work_in_progress`"
    end
  end

  def post_register(bot)
    bot.command :need_help do |event, *_args|
      perform_complete bot, event, [:need_help]
    end
    bot.command :can_help do |event, *_args|
      perform_complete bot, event, [:can_help]
    end
    bot.command [:work_in_progress, :wip] do |event, *_args|
      perform_complete bot, event, [:work_in_progress]
    end
  end

  def help_message
    [{ command: keywords.first, args: 'STATUS', description: 'Au choix need_help, can_help, work_in_progress' },
     { command: 'wip', args: '', description: 'raccourci pour $status _work_in_progress' },
     { command: 'can_help', args: '', description: 'raccourci pour $status can_help' },
     { command: 'need_help', args: '', description: 'raccourci pour $status need_help' }]
  end
end
