class CreateKeys < ActiveRecord::Migration
  def change
    create_table :keys do |t|
      t.text :value
      t.text :remark
      t.references :user

    end
  end
end
