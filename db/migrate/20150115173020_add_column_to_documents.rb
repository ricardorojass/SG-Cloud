class AddColumnToDocuments < ActiveRecord::Migration
  def change
    add_column :documents, :current_version_id, :integer
  end
end
