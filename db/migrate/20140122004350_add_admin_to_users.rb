class AddAdminToUsers < ActiveRecord::Migration
  def change
    # total hack at the moment
    # u = User.where(email: 'anthony@durity.com').first
    # u.admin = true
    # u.save!
    add_column :users, :admin, :boolean, :default => false
  end
end
