class AddHerokuApiKeyToBoards < ActiveRecord::Migration
  def change
    add_column :boards, :heroku_api_key, :string
  end
end
