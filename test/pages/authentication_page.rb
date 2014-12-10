module AuthenticationPage
  def sign_in(user)
    visit root_url

    fill_in "user[email]", with: user.email
    click_on t("users.new.submit")
  end
end
