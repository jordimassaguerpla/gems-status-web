class AddDefaultValueToGemsUrlAtRubyApplications < ActiveRecord::Migration
  def change
    change_column :ruby_applications, :gems_url, :string, :default => "https://rubygems.org/gems"
  end
end
