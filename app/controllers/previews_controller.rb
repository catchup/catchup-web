class PreviewsController < ApplicationController
  def create
    # TODO: get app name from card
    # TODO: get fork name randomly
    # TODO: get tarball from card
    PreviewJob.new.async.perform(
      Heroku::Application.from_name("catchup-web"),
      Heroku::Application.from_name("catchup-web-fork"),
      "https://github.com/catchup/catchup-web/archive/whatever.tar.gz"
    )
  end
end
