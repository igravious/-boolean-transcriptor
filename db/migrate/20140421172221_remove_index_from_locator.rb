class RemoveIndexFromLocator < ActiveRecord::Migration
  def change
      remove_index :locators, [:scan_id, :heading_id]
  end
end
