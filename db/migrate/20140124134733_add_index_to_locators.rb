class AddIndexToLocators < ActiveRecord::Migration
  def change
    add_index :locators, [:scan_id, :heading_id], :unique => true
  end
end
