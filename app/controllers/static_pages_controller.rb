class StaticPagesController < ApplicationController
  def home
    flash.now[:notice] = 'Tu viens de réveiller The Hacking Bot, merci !' if DiscordBot.keep_alive
    @page_title = 'The Hacking Bot | Accueil'
  end
end
