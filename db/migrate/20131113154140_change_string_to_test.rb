class ChangeStringToTest < ActiveRecord::Migration
  def change
    change_column :security_alerts, :desc, :text
  end
end
