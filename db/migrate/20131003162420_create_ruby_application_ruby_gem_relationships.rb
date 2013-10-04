class CreateRubyApplicationRubyGemRelationships < ActiveRecord::Migration
  def change
    create_table :ruby_application_ruby_gem_relationships do |t|
      t.integer :ruby_application_id
      t.integer :ruby_gem_id

      t.timestamps
    end
  end
end
