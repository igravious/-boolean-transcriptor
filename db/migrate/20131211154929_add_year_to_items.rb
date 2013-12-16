class AddYearToItems < ActiveRecord::Migration
  def up
    add_column :items, :year, :date

    Item.find_each do |item|
      begin
        d = item.item_date.to_i
        item.year = item.item_date
      rescue
        # in DotW, dd, m, yyyy format - to_i barfs but .year works
        item.year = item.item_date.year
      end
      item.save
    end
  end

  def down
    remove_column :items, :year
  end
end
