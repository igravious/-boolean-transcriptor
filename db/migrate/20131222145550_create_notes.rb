class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :note_type
      t.binary :bytes

      t.timestamps
    end
  end
end
