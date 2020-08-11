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

  def add_help; end
end
