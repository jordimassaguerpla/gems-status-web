class AddStatusToSecurityAlert < ActiveRecord::Migration
  def change
    add_column :security_alerts, :status, :integer
  end
end
