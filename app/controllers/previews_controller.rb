class PreviewsController < ApplicationController
  def create
    card = Card.find(params[:card_id])

    PreviewJob.new.async.perform(
      Heroku::Application.from_name(card.app_name),
      Heroku::Application.from_name(random_suffix(card.app_name)),
      card.branch_tarball
    )
  end

  private

  def random_suffix(prefix)
    name = 1.upto(8).inject("") { |mem, _| mem + (Random.rand(25) + 65).chr }
    "#{prefix}-#{name}".downcase
  end
end
