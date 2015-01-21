class AddStatusToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :status, :integer
  end
end
