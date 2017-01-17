class CreateAnalyses < ActiveRecord::Migration
  def change
    create_table :analyses do |t|
      t.integer :user_id
      t.integer :total
      t.timestamps null: false
    end
  end
end
