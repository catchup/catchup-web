ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'database_cleaner'
require "mocha/mini_test"

class ActiveSupport::TestCase
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
