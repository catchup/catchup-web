class CreateBoardsSubscriptions < ActiveRecord::Migration
  def change
    create_table :boards_subscriptions do |t|
      t.belongs_to :board, index: true
      t.belongs_to :user,  index: true
    end
  end
end
