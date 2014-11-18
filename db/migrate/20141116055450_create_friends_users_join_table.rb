class CreateFriendsUsersJoinTable < ActiveRecord::Migration
  def change
    create_table :account_histories do |t|
      t.belongs_to :user
      t.belongs_to :friends, :class=>"User"

    end
  end
end
