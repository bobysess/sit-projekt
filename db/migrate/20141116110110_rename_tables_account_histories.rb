class RenameTablesAccountHistories < ActiveRecord::Migration
  def change
     rename_table :account_histories ,:users_friends
  end
end
