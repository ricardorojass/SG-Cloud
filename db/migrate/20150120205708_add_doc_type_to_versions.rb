class AddDocTypeToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :doc_type, :string
  end
end
