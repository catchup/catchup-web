class CreateBoardsOwners < ActiveRecord::Migration
  def change
    create_table :boards_owners do |t|
      t.belongs_to :user, index: true
      t.belongs_to :board, index: true
    end
  end
end
