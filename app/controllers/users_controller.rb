class UsersController < ApplicationController
  layout 'layouts/users'

  def show
    @user = User.find(params[:id])
    if user_signed_in? && current_user == @user
      unless @user.discord?
        flash.now[:danger] = "Merci de lier le compte discord voici la commande à envoyer au bot : $verify #{@user.email} #{@user.create_discord_verify_token}"
      end
      render :profile
    else
      render :show
    end
  end

  def index
    @users = User.order(created_at: :desc)
  end
end
