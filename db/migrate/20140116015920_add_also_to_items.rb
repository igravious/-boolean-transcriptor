class AddAlsoToItems < ActiveRecord::Migration
  def change
    add_column :items, :also, :date
  end
end
