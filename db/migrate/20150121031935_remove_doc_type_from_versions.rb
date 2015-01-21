class RemoveDocTypeFromVersions < ActiveRecord::Migration
  def change
    remove_column :versions, :doc_type, :string
  end
end
