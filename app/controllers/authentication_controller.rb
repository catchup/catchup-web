class AuthenticationController < ApplicationController
  skip_before_filter :authenticate, only: [:github, :failure]

  def signout
    session[:current_user] = nil

    redirect_to root_url
  end

  def github
    user = User.find_or_initialize_by(
      auth_provider: :github,
      auth_uid: env["omniauth.auth"].uid
    )
    user.update_with_auth_schema!(env["omniauth.auth"])

    session[:current_user] = user.id

    redirect_to boards_url
  end

  def heroku
    board_id = request.env['omniauth.params']['board_id']
    api_key = env["omniauth.auth"].credentials.token

    redirect_to board_applinks_url(board_id: board_id, api_key: api_key)
  end

  def failure
    redirect_to root_url, notice: t("welcome.index.auth_failure")
  end
end
