class CreateVersions < ActiveRecord::Migration
  def change
    create_table :versions do |t|
      t.string :number
      t.references :document, index: true
      t.string :ubication
      t.string :docdrive_id

      t.timestamps null: false
    end
    add_foreign_key :versions, :documents
  end
end
