class CreateDocuments < ActiveRecord::Migration
  def change
    create_table :documents do |t|
      t.string :code
      t.string :origin
      t.string :type
      t.string :ubication

      t.timestamps null: false
    end
  end
end
