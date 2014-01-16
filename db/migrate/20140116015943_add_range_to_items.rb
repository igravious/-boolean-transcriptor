class AddRangeToItems < ActiveRecord::Migration
  def change
    add_column :items, :range, :date
  end
end
