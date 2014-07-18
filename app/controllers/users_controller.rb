class UsersController < ApplicationController
  def new
  end

  def create
    user_email = user_params.fetch(:email)

    session[:current_user] = user_email
    User.find_or_create_by(email: user_email)

    redirect_to root_path
  end

  private

  def user_params
    params.require(:user)
          .permit(:email)
  end
end
