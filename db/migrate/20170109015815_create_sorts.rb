class CreateSorts < ActiveRecord::Migration
  def change
    create_table :sorts do |t|
      t.string :name
      t.references :category, foreign_key: true
      t.timestamps null: false
    end
  end
end
