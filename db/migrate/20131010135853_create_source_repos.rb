class CreateSourceRepos < ActiveRecord::Migration
  def change
    create_table :source_repos do |t|
      t.string :name
      t.string :url

      t.timestamps
    end
  end
end
