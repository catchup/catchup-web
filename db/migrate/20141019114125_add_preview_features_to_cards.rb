class AddPreviewFeaturesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :branch_tarball, :string
    add_column :cards, :app_name, :string
    add_column :cards, :preview_url, :string
  end
end
