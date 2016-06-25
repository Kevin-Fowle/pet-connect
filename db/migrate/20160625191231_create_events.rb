class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.references :pairing
      t.references :timeslot

      t.timestamps null: false
    end
  end
end
