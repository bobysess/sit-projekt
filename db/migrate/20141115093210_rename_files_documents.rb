class RenameFilesDocuments < ActiveRecord::Migration
  def change
      rename_table  :files, :documents
  end
end
