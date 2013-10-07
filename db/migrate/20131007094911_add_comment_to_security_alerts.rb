class AddCommentToSecurityAlerts < ActiveRecord::Migration
  def change
    add_column :security_alerts, :comment, :string
  end
end
