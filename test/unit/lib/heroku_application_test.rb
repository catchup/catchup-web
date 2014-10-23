require "test_helper"

class Heroku::ApplicationTest < ActiveSupport::TestCase
  test "name initialization" do
    application = Heroku::Application.from_name("abcdef")
    assert_equal "abcdef", application.name
  end

  test "url reflects name" do
    application = Heroku::Application.from_name("whatever")
    assert_equal "http://whatever.herokuapp.com", application.url
  end
end
