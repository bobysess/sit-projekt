class CreateLoans < ActiveRecord::Migration
  def change
    create_table :loans do |t|
       t.references :key
       t.references :user
       t.references :friend
    end
  end
end
