class UsersController < ApplicationController
  before_action :authenticate_user!, only: [:profile]

  def show
    @user = User.find(params[:id])
  end

  def profile
    @user = current_user
  end
end
