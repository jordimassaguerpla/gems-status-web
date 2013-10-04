class CreateRubyApplications < ActiveRecord::Migration
  def change
    create_table :ruby_applications do |t|
      t.string :name
      t.string :filename
      t.string :gems_url

      t.timestamps
    end
  end
end
