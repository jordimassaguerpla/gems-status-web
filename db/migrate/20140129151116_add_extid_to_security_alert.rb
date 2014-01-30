class AddExtidToSecurityAlert < ActiveRecord::Migration
  def change
    add_column :security_alerts, :extid, :string
  end
end
