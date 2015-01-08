class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :card, index: true
      t.belongs_to :user, index: true
      t.text :text

      t.timestamps nullable: true
    end
  end
end
