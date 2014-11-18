class CreateKeyPairs < ActiveRecord::Migration
  def change
    create_table :key_pairs do |t|
      t.text :privat_key
      t.text :public_key
      t.string :remark
    end
  end
end
