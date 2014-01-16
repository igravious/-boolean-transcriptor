class RemoveYearFromItems < ActiveRecord::Migration
  def change
    remove_column :items, :year, :string
  end
end
