class AddScansAcceptedToMember < ActiveRecord::Migration
  def change
    add_column :members, :scans_accepted, :integer, default: 0
  end
end
