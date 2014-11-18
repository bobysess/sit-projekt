class RenameTableTableFriendshipsUsers < ActiveRecord::Migration
  def change
     rename_table :table_friendships_users ,:friendships_users
  end
end
