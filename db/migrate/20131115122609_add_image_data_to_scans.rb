class AddImageDataToScans < ActiveRecord::Migration
  def change
    add_column :scans, :image_data, :binary
  end
end
