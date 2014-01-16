class AddIndexesToItems < ActiveRecord::Migration
  def change
    add_index :items, [:fa_seq, :fa_structure], :unique => true
  end
end
