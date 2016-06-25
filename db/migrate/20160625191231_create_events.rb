class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :pairing, index: true, foreign_key: true
      t.references :pet_owner_timeslot, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
