class RemoveColumnFromVersions < ActiveRecord::Migration
  def change
    remove_column :versions, :document_id, :integer
  end
end
