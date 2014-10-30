class PreviewsController < ApplicationController
  def create
    card  = Card.find(params[:card_id])
    board = card.board

    PreviewJob.new.async.perform(
      Heroku::Application.from_name(card.app_name, board.heroku_api_key),
      Heroku::Application.from_name(random_suffix(card.app_name), board.heroku_api_key),
      card.branch_tarball,
      card
    )

    redirect_to [board, card]
  end

  private

  def random_suffix(prefix)
    name = 1.upto(8).inject("") { |mem, _| mem + (Random.rand(25) + 65).chr }
    "#{prefix}-#{name}".downcase
  end
end
