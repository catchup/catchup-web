class ApplinksController < ApplicationController
  def index
    @heroku_apps = [
      HerokuApp.new("Foo"),
      HerokuApp.new("Bar")
    ]
  end
end
