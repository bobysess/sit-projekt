class RenameTableUsersFriendsToFriendships < ActiveRecord::Migration
  def change
      rename_table :users_friends, :friendships
  end
end
