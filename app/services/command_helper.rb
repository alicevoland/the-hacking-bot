# class CommandHelper
#   def initialize(event)
#     @event = event
#   end

#   def get_user
#     user = User.find_by(discord_id: $event.user.id)
#     unless user
#       event.respond 'Utilisateur non trouvé, as-tu lié ton compte ? <https://the-hacking-bot.herokuapp.com/discord_verify>'
#       return false
#     end
#     user
#   end

#   def parse_status(user, status)
#     unless status
#       event.respond "Ton status actuel est #{user.status}"
#       return false
#     end
#     if status.downcase == user.status.downcase
#       event.respond "Tu gardes le même statut : #{user.status}"
#       return false
#     end
#     status
#   end
# end
