class AddMonthToItems < ActiveRecord::Migration
  def change
    add_column :items, :month, :string
  end
end
