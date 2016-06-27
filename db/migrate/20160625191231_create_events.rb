class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.date :date
      t.time :start_time
      t.time :end_time
      t.boolean :accepted
      t.references :user
      t.references :organization

      t.timestamps null: false
    end
  end
end
