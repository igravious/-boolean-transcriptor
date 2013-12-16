class CreateScans < ActiveRecord::Migration
  def change
    create_table :scans do |t|
      t.string :stringified
      t.string :file_name
      t.integer :institution
      t.string :prefix
      t.integer :major_seq
      t.integer :seq
      t.integer :minor_seq
      t.references :item, index: true
      t.integer :state
      t.text :transcription

      t.timestamps
    end
  end
end
