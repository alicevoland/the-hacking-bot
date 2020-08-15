class MentionCommand < BaseCommand
  def keywords
    %i[mention @]
  end

  def perform(bot, event, args)
    return unless user = check_user_by_discord_id(event)

    status = args.join('_').to_sym
    return unless status = check_status(event, status)

    discord_users = User.where(visible: true, status: status).map do |user|
      discord_user = bot.users[user.discord_id]
    end
    mentions = discord_users.map do |discord_user|
      discord_user.mention
    end.join(', ')

    event.respond "#{status} : #{discord_users.size} => #{mentions}"
  end

  def check_status(event, status)
    if status == :wip || status == :work_in_progree
      :work_in_progress
    elsif status == :need_help || status == :can_help
      status
    else
      event.respond "Statut #{status} inconnu"
      false
    end
  end

  def help_message
    [{ command: keywords.first, args: 'STATUS', description: 'Mentionne les utilisateurs visibles et avec statut=SATUS' }]
  end
end
