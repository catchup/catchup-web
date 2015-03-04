class MoveRepositoryInformationToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :repository_url, :string
    remove_column :cards, :branch_tarball
    add_column :cards, :branch_name, :string
  end
end
