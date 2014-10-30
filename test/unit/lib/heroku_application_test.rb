require "test_helper"

class Heroku::ApplicationTest < ActiveSupport::TestCase
  test "name initialization" do
    application = Heroku::Application.with(name: "abcdef", api_key: "irrelevant")
    assert_equal "abcdef", application.name
  end

  test "url reflects name" do
    application = Heroku::Application.with(name: "whatever", api_key: "irrelevant")
    assert_equal "http://whatever.herokuapp.com", application.url
  end
end
