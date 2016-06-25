class CreatePetOwnerTimeslots < ActiveRecord::Migration
  def change
    create_table :pet_owner_timeslots do |t|
      t.references :user, index: true, foreign_key: true
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
