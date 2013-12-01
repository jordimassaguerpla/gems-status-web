class AddBetaUserToUser < ActiveRecord::Migration
  def change
    add_column :users, :beta_user, :integer, :default => 0
  end
end
