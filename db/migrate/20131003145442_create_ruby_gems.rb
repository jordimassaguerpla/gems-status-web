class CreateRubyGems < ActiveRecord::Migration
  def change
    create_table :ruby_gems do |t|
      t.string :name
      t.string :version
      t.string :license

      t.timestamps
    end
  end
end
