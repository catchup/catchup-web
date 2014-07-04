class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards, -> { order(position: :asc) }

  def create_card(params)
    card = cards.create(params)
    card.move_to_top

    card
  end
end
