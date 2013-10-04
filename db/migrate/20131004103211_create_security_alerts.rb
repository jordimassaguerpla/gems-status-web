class CreateSecurityAlerts < ActiveRecord::Migration
  def change
    create_table :security_alerts do |t|
      t.integer :ruby_gem_id
      t.integer :ruby_application_id
      t.string :desc
      t.string :version_fix

      t.timestamps
    end
  end
end
