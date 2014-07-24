class List < ActiveRecord::Base
  belongs_to :board
  has_many :cards, -> { order(position: :asc) }

  def create_card(params)
    card = cards.create(params)
    card.move_to(
      list_id: self.id,
      position: 0
    )

    card
  end
end
