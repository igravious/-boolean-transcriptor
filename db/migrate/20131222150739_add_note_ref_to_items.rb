class AddNoteRefToItems < ActiveRecord::Migration
  def change
    add_column :items, :note, :reference
  end
end
