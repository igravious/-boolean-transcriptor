class AddDirectoryToScans < ActiveRecord::Migration
  def change
    add_column :scans, :directory, :string
  end
end
