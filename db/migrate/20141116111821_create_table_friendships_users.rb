class CreateTableFriendshipsUsers < ActiveRecord::Migration
  def change
    create_table :table_friendships_users do |t|
      t.references :user
      t.references :friend, :class=>"User"
    end
  end
end
