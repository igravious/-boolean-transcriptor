class AddSubToItems < ActiveRecord::Migration
  def change
    add_column :items, :sub, :integer
  end
end
