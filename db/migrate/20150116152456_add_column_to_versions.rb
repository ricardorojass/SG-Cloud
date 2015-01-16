class AddColumnToVersions < ActiveRecord::Migration
  def change
    add_reference :versions, :document, index: true
    add_foreign_key :versions, :documents
  end
end
