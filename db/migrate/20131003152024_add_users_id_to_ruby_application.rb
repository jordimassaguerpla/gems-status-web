class AddUsersIdToRubyApplication < ActiveRecord::Migration
  def change
    add_column :ruby_applications, :user_id, :integer
  end
end
