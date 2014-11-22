class AddKeyPublicAndKeyPrivateToUsers < ActiveRecord::Migration
  def change
     add_column :users, :key_public ,:text
     add_column :users, :key_private, :text
     add_column :users, :test_pass_plain, :text
     add_column :users, :test_pass_encrypt, :text
  end
end
