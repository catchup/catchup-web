ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'capybara/poltergeist'
require 'database_cleaner'

Capybara.javascript_driver = :poltergeist

class ActiveSupport::TestCase
  fixtures :all
end

class ActionDispatch::IntegrationTest
  include Capybara::DSL
  include AbstractController::Translation

  DatabaseCleaner.strategy = :truncation
  self.use_transactional_fixtures = false

  setup do
    DatabaseCleaner.start
  end

  teardown do
    DatabaseCleaner.clean
  end

  def in_order?(first, last)
    page.body.index(first) < page.body.index(last)
  end

  def refresh
    visit current_url
  end
end
