class CreateRatings < ActiveRecord::Migration
  def change
    create_table :ratings do |t|
      t.integer :stars
      t.text :description
      t.references :event, index: true, foreign_key: true
      t.references :ratable, polymorphic: true, index: true

      t.timestamps null: false
    end
  end
end
