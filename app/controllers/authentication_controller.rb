class AuthenticationController < ApplicationController
  skip_before_filter :authenticate, only: [:github, :failure]

  def signout
    session[:current_user] = nil

    redirect_to root_url
  end

  def github
    user = User.authenticate(:github, env["omniauth.auth"].uid)
    user.avatar_url = env["omniauth.auth"].info.image
    user.email = env["omniauth.auth"].info.email
    user.nickname = env["omniauth.auth"].info.nickname
    user.save!

    session[:current_user] = user.id

    redirect_to boards_url
  end

  def failure
    redirect_to root_url, notice: t("anonymous.index.auth_failure")
  end
end
