require 'test_helper'
require "pages/authentication_page"

class MockAuthenticationTest < ActionDispatch::IntegrationTest
  include AuthenticationPage

  test "User authenticates via an arbitrary e-mail" do
    sign_in users(:antonio)
  end
end
