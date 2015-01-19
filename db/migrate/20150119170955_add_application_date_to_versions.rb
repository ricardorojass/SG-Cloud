class AddApplicationDateToVersions < ActiveRecord::Migration
  def change
    add_column :versions, :application_date, :date
  end
end
