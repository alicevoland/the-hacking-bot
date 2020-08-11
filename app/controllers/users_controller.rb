class UsersController < ApplicationController
  before_action :authenticate_user!, only: %i[profile discord_verify]

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
  end

  def discord_verify
    @user = current_user
    @discord_verify_token = SecureRandom.base64(10)
    @user.update(discord_verify_digest: BCrypt::Password.create(@discord_verify_token))
  end

  def index
    @users = User.order(created_at: :desc)
  end
end
