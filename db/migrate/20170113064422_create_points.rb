class CreatePoints < ActiveRecord::Migration
  def change
    create_table :points do |t|
      t.string :name
      t.integer :each_point
      t.timestamps null: false
    end
  end
end
