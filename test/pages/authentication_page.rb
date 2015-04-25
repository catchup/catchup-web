module AuthenticationPage
  def sign_in(user)
    OmniAuth.config.add_mock(:github, info: {
      nickname: user.nickname, image: user.avatar_url, email: user.email
    }) unless @will_forget_credentials

    visit root_path
    click_on t("welcome.index.signup")
  end

  def sign_out
    visit auth_signout_path
  end

  def has_account_information?(user)
    has_text?(user.nickname) &&
    has_text?(user.email) &&
    has_css?("img[src*='#{user.avatar_url}']")
  end

  def can_visit_restricted_page?
    visit boards_path
    boards_path == current_path
  end

  def authentication_failed?
    has_text? t("welcome.index.auth_failure")
  end

  def forget_credentials
    @will_forget_credentials = true
    OmniAuth.config.mock_auth[:github] = :invalid_credentials
  end
end
