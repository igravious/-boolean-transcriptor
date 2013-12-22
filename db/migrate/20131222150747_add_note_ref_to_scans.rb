class AddNoteRefToScans < ActiveRecord::Migration
  def change
    add_column :scans, :note, :reference
  end
end
