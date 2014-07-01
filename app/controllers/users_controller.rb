class UsersController < ApplicationController
  def new
  end

  def create
    session[:current_user] = user_params.fetch(:email)

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user)
          .permit(:email)
  end
end
