class AddCommentaryToItems < ActiveRecord::Migration
  def change
    add_column :items, :commentary, :string
  end
end
