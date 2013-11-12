class AddSecKeyToSecurityAlert < ActiveRecord::Migration
  def change
    add_column :security_alerts, :sec_key, :string
  end
end
