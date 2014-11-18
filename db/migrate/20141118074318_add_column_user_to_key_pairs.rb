class AddColumnUserToKeyPairs < ActiveRecord::Migration
  def change
     add_reference :key_pairs, :user
  end
end
