class AddReceiveEmailsToUser < ActiveRecord::Migration
  def change
    add_column :users, :receive_emails, :integer, :default => 1
  end
end
