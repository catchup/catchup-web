module AuthenticationPage
  def sign_in(user)
    if page.driver.respond_to?(:basic_auth)
      page.driver.basic_auth(user.email, user.password)
    elsif page.driver.respond_to?(:basic_authorize)
      page.driver.basic_authorize(user.email, user.password)
    elsif page.driver.respond_to?(:browser) && page.driver.browser.respond_to?(:basic_authorize)
      page.driver.browser.basic_authorize(user.email, user.password)
    else
      raise "I don't know how to log in!"
    end

    visit root_path
  end
end
