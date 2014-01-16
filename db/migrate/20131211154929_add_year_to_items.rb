class AddYearToItems < ActiveRecord::Migration
  def up
    add_column :items, :year
  end

  def down
    remove_column :items, :year
  end
end
