class CreateLocators < ActiveRecord::Migration
  def change
    create_table :locators do |t|
      t.integer :heading_id
      t.integer :scan_id

      t.timestamps
    end
  end
end
