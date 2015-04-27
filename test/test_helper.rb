ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require "capybara/rails"
require "capybara/poltergeist"
require "database_cleaner"
require "mocha/mini_test"
require "pages/authentication_page"

Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
end

class ActionMailer::TestCase
  def sent_to_everyone?(email)
    email.to.include?(users(:ali).email) &&
    email.to.include?(users(:antonio).email)
  end

  def delivered_email?
    ActionMailer::Base.deliveries.last != nil
  end
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include AbstractController::Translation
  include AuthenticationPage

  DatabaseCleaner.strategy = :truncation
  self.use_transactional_fixtures = false

  setup do
    OmniAuth.config.test_mode = true
    DatabaseCleaner.start
  end

  teardown do
    OmniAuth.config.test_mode = false
    DatabaseCleaner.clean
  end

  def in_order?(first, last)
    page.body.index(first) < page.body.index(last)
  end

  def refresh
    visit current_url
  end
end
