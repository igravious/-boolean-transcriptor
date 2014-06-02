class RemoveIndexAgainFromLocators < ActiveRecord::Migration
  def change
    remove_index :locators, [:scan_id, :heading_id, :content]
  end
end
