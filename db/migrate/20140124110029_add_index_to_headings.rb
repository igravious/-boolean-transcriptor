class AddIndexToHeadings < ActiveRecord::Migration
  def change
    add_index :headings, [:subject], :unique => true
  end
end
