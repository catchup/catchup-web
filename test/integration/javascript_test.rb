class JavascriptTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
    Capybara.session_name = user_1
  end

  teardown do
    Capybara.use_default_driver
  end

  protected

  def user_1
    @user_1 ||= SecureRandom.hex
  end

  def user_2
    @user_2 ||= SecureRandom.hex
  end
end
