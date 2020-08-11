class CommandList
  attr_accessor :bot
  attr_accessor :list

  def initialize bot
    @bot = bot
    @list = []
  end

  def add_command command
    list.append command
    command.register bot
  end

  def add_help
    helps = []
    list.each { |command| helps += command.help_message }
    comm_size = helps.map { |h| h[:command].size }.max
    args_size = helps.map { |h| h[:args].size }.max
    desc_size = helps.map { |h| h[:description].size }.max
    bot.command :help do |event|
      str = "Liste des commandes\n"
      str += '-' * (comm_size + args_size + desc_size + 5) + "\n"
      str += format("`$%-#{comm_size}s  %-#{args_size}s` : %s", '$COMMAND', 'ARGS', 'DESCRIPTION') + "\n"
      helps.each do |help|
        str += format("`$%-#{comm_size}s  %-#{args_size}s` : %s", help[:command], help[:args], help[:description]) + "\n"
      end
      str += '-' * (comm_size + args_size + desc_size + 5) + "\n"
      event.respond(str)
      event.respond '-- A bientôt sur : <https://the-hacking-bot.herokuapp.com>'
    end
  end
end
