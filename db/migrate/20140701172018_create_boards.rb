class CreateBoards < ActiveRecord::Migration
  def change
    create_table :boards do |t|
      t.string :title

      t.timestamps nullable: true
    end
  end
end
