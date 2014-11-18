class CreateFiles < ActiveRecord::Migration
  def change
    create_table :files do |t|
      t.text :name
      t.text :path
      t.text :remark
      t.references :user
      t.references :key
    end
  end
end
