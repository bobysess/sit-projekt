class RenameColumnFriendsIdInFriendships < ActiveRecord::Migration
  def change
    rename_column :friendships,:friends_id,:friend_id
  end
end
