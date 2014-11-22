class CreateDistributedDocuments < ActiveRecord::Migration
  def change
    create_table :distributed_documents do |t|
        t.references :user
        t.references :friend
        t.references :document
        t.text :key
    end
  end
end
