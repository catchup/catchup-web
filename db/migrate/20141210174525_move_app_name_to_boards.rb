class MoveAppNameToBoards < ActiveRecord::Migration
  # Redefine models in migrations
  # (Ref.: http://guides.rubyonrails.org/migrations.html#using-models-in-your-migrations)
  class Board < ActiveRecord::Base
    has_many :lists
    has_many :cards, through: :lists
  end

  class List < ActiveRecord::Base
    belongs_to :board
    has_many :cards
  end

  class Card < ActiveRecord::Base
    belongs_to :list

    delegate :board, to: :list
  end

  def up
    add_column :boards, :app_name, :string
    Card.where.not(app_name: '').find_each do |card|
      card.board.update_attributes(app_name: card.app_name)
    end
    remove_column :cards, :app_name
  end

  def down
    add_column :cards, :app_name, :string
    Board.find_each do |board|
      board.cards.update_all(app_name: board.app_name)
    end
    remove_column :boards, :app_name
  end
end
