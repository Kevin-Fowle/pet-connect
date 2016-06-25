class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :stars
      t.text :description
      t.references :event
      t.references :ratable, polymorphic: true

      t.timestamps null: false
    end
  end
end
