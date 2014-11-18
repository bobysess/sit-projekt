class AddPasswordConfirmToUsers < ActiveRecord::Migration
  def change
     add_column :users, :confirm_password ,:text
  end
end
