class DeleteRepositoryUrlFromBoards < ActiveRecord::Migration
  def change
    remove_column :boards, :repository_url
  end
end
