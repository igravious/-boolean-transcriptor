class AddUniqueIndexToLocators < ActiveRecord::Migration
  def change
    add_index :locators, [:scan_id, :heading_id, :content], :unique => true
  end
end
