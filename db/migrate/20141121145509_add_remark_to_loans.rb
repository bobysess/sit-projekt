class AddRemarkToLoans < ActiveRecord::Migration
  def change
     add_column :loans, :remark ,:text
  end
end
