class AddContentToLocators < ActiveRecord::Migration
  def change
      add_column :locators, :content, :string
  end
end
