class AddExtraToItems < ActiveRecord::Migration
  def change
    add_column :items, :pp_extra, :string
  end
end
