class AddColumnTimesLoggedInToUser < ActiveRecord::Migration
  def change
    add_column :users, :times_logged_in, :integer, default: 0
  end
end
