class CreatePetTimeslots < ActiveRecord::Migration
  def change
    create_table :pettimeslots do |t|
      t.references :pet
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
