class AddAmendedIndexToLocators < ActiveRecord::Migration
  def change
      add_index :locators, [:scan_id, :heading_id, :content]
  end
end
