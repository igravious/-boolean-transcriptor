class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :division
      t.string :description
      t.integer :folios
      t.integer :pp
      t.date :item_date
      t.integer :penner
      t.string :fa_seq
      t.string :fa_structure

      t.timestamps
    end
  end
end
