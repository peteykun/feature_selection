class CreateRuns < ActiveRecord::Migration
  def change
    create_table :runs do |t|
      t.string :name
      t.string :reduct_set
      t.text :rules

      t.timestamps null: false
    end
  end
end
