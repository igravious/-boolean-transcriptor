class AddMemberToNotes < ActiveRecord::Migration
  def change
    add_column :notes, :member_id, :integer
  end
end
