class CreateHeadings < ActiveRecord::Migration
  def change
    create_table :headings do |t|
      t.string :subject, :null => false
      t.string :type, :null => false

      t.timestamps
    end
  end
end
