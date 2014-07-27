require 'test_helper'

class MockAuthenticationTest < ActionDispatch::IntegrationTest
  test 'User authenticates via an arbitrary e-mail' do
    visit root_url

    fill_in 'user[email]', with: 'as-cii@me.com'
    click_on t('users.new.login')

    assert page.has_text? "as-cii@me.com"
  end
end
