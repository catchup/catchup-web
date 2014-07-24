class UsersController < ApplicationController
  def new
    redirect_to boards_path if signed_in?

    @user = User.new
  end

  def create
    @user = User.find_or_create_by(user_params)

    if @user.valid?
      session[:current_user] = @user.email
      redirect_to root_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user)
          .permit(:email)
  end
end
