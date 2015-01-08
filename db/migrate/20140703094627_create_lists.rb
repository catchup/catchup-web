class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.string :title
      t.integer :position
      t.belongs_to :board, index: true

      t.timestamps nullable: true
    end
  end
end
