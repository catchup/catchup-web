class CreateCards < ActiveRecord::Migration
  def change
    create_table :cards do |t|
      t.string :title
      t.belongs_to :list, index: true

      t.timestamps nullable: true
    end
  end
end
