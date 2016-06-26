class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.boolean :accepted
      t.references :user
      t.references :orgnization

      t.timestamps null: false
    end
  end
end
