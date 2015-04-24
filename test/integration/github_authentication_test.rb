require "test_helper"

class GitHubAuthenticationTest < ActionDispatch::IntegrationTest
  def setup
    Capybara.ignore_hidden_elements = false
    @irrelevant_user = User.new(
      nickname: "as-cii", avatar_url: "as-cii.jpg", email: "me@as-cii.com"
    )
  end

  def teardown
    Capybara.ignore_hidden_elements = true
  end

  test "Anonymous signs up" do
    # Given I haven't signed in yet

    # When I start the sign in process
    sign_in(@irrelevant_user)

    # Then I get signed in with my account information
    assert has_account_information?(@irrelevant_user)
  end

  test "Anonymous signs in" do
    # Given I have previously signed in
    @irrelevant_user.save!

    # When I start the sign in process
    sign_in(@irrelevant_user)

    # Then I get signed in with my previous account information
    assert has_account_information?(@irrelevant_user)
  end

  test "Anonymous fails to authenticate" do
    # Given I don't remember my OAuth credentials
    forget_credentials

    # When I start the sign in process
    sign_in(@irrelevant_user)

    # Then I won't be able to sign in
    assert authentication_failed?
  end

  test "Signed in user signs out" do
    # Given I am already signed in
    sign_in(@irrelevant_user)

    # When I sign out
    sign_out

    # Then my account information won't be displayed anymore
    refute has_account_information?(@irrelevant_user)

    # And I cannot visit restricted pages anymore
    refute can_visit_restricted_page?
  end
end
