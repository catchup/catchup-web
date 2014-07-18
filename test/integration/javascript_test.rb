class JavascriptTest < ActionDispatch::IntegrationTest
  setup do
    Capybara.current_driver = Capybara.javascript_driver
  end

  teardown do
    Capybara.use_default_driver
  end
end
