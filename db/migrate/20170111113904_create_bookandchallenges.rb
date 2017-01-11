class CreateBookandchallenges < ActiveRecord::Migration
  def change
    create_table :bookandchallenges do |t|
      t.integer :challenge_id
      t.integer :booking_id

      t.timestamps null: false
    end
  end
end
