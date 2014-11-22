class AddKeyValueToLoans < ActiveRecord::Migration
  def change
     add_column :loans, :key_value, :text
  end
end
