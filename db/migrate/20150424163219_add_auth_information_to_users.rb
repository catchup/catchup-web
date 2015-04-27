class AddAuthInformationToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.string :avatar_url
      t.string :auth_provider
      t.string :auth_uid
      t.remove :first_name
      t.string :nickname
    end
  end
end
