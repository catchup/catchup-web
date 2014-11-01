class AddPreviewingToCards < ActiveRecord::Migration
  def change
    add_column :cards, :previewing, :boolean
  end
end
