class CreateLastRuns < ActiveRecord::Migration
  def change
    create_table :last_runs do |t|
      t.timestamps
    end
  end
end
