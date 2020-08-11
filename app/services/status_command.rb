class StatusCommand < BaseCommand
  def keywords
    %i[status statut set]
  end

  def perform _bot, event, args
    return unless user = check_user_by_discord_id(event)

    if args.empty?
      event.respond "Ton status actuel est #{user.status}"
      return
    end

    status = args.join('_').downcase

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

  def post_register(bot)
    bot.command :need_help do |event, *_args|
      perform bot, event, [:need_help]
    end
    bot.command :can_help do |event, *_args|
      perform bot, event, [:can_help]
    end
    bot.command [:work_in_progress, :wip] do |event, *_args|
      perform bot, event, [:work_in_progress]
    end
  end
end
