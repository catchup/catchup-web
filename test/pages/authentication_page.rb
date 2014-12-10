module AuthenticationPage
  def sign_in(user)
    visit root_path

    fill_in "user[email]", with: user.email
    click_on t("users.new.submit")
  end

  def sign_out
    browser = Capybara.current_session.driver.browser
    if browser.respond_to?(:clear_cookies)
      browser.clear_cookies
    elsif browser.respond_to?(:manage) and browser.manage.respond_to?(:delete_all_cookies)
      browser.manage.delete_all_cookies
    else
      raise "Don't know how to clear cookies. Weird driver?"
    end
  end
end
