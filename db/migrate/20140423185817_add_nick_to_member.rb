class AddNickToMember < ActiveRecord::Migration
  def change
    add_column :members, :nick, :string
  end
end
