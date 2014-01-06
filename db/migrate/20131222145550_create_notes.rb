class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.integer :type
      t.binary :bytes
      t.belongs_to :item
      t.belongs_to :scan

      t.timestamps
    end
  end
end
