class ChangeUsers < ActiveRecord::Migration
  def change
     remove_column :users ,:test_pass_plain
     remove_column :users, :test_pass_encrypt
     add_column :users , :super_key, :text
  end
end
