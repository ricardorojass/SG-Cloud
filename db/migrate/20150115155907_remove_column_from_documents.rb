class RemoveColumnFromDocuments < ActiveRecord::Migration
  def change
    remove_column :documents, :ubication, :string
  end
end
